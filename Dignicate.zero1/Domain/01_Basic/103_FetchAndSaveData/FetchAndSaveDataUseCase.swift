//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

final class FetchAndSaveDataUseCase {

    private let disposeBag = DisposeBag()

    private let fetchTrigger = PublishRelay<CompanyInfo.ID>()

    private let fetchLastUpdatedTrigger = PublishRelay<Void>()

    private let saveTrigger = PublishRelay<CompanyInfo>()

    private let clearLocalDataTrigger = PublishRelay<Void>()

    private let dataStateRelay = PublishRelay<DataState>()

    private let processStateRelay = BehaviorRelay<ProcessState>(value: .noProcess)

    private let saveCompleteRelay = PublishRelay<Void>()

    private let lastUpdatedRelay = PublishRelay<String?>()

    var dataState: Observable<DataState> {
        dataStateRelay
            .asObservable()
    }

    var processState: Observable<ProcessState> {
        processStateRelay
            .asObservable()
    }

    var lastUpdated: Observable<String?> {
        lastUpdatedRelay.asObservable()
    }

    enum DataState {
        case remote(companyInfo: CompanyInfo)
        case local(companyInfo: CompanyInfo)
        case noData

        var data: CompanyInfo? {
            switch self {
            case .remote(let data): return data
            case .local(let data): return data
            case .noData: return nil
            }
        }
    }

    enum ProcessState {
        case noProcess
        case fetching
        case fetchedLocally
        case saving
        case saved
        case clearing
        case cleared

        var isFetchAvailable: Bool {
            switch self {
            case .noProcess, .fetchedLocally, .saved, .cleared:
                return true
            case .fetching, .saving, .clearing:
                return false
            }
        }

        var isClearAvailable: Bool {
            switch self {
            case .noProcess, .fetchedLocally, .saved:
                return true
            case .clearing, .cleared, .fetching, .saving:
                return false
            }
        }
    }

    init(repository: CompanyInfoFetchAndSaveRepositoryProtocol) {
        fetchTrigger
            .flatMapLatest { id in
                repository.fetch(id: id)
            }
            .bind(to: dataStateRelay)
            .disposed(by: disposeBag)

        fetchTrigger
            .map { _ in ProcessState.fetching }
            .bind(to: processStateRelay)
            .disposed(by: disposeBag)

        dataStateRelay
            .compactMap {
                switch $0 {
                case .remote(let data): return data
                case .local, .noData: return nil
                }
            }
            .bind(to: saveTrigger)
            .disposed(by: disposeBag)

        let localFetchTrigger = dataStateRelay
            .filter {
                switch $0 {
                case .remote, .noData: return false
                case .local: return true
                }
            }
            .map { _ in () }
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)

        localFetchTrigger
            .bind(to: fetchLastUpdatedTrigger)
            .disposed(by: disposeBag)

        localFetchTrigger
            .map { _ in ProcessState.fetchedLocally }
            .bind(to: processStateRelay)
            .disposed(by: disposeBag)

        saveTrigger
            .flatMapLatest {
                repository.saveToLocal(companyInfo: $0)
            }
            .bind(to: saveCompleteRelay)
            .disposed(by: disposeBag)

        saveTrigger
            .map { _ in ProcessState.saving }
            .bind(to: processStateRelay)
            .disposed(by: disposeBag)

        saveCompleteRelay
            .bind(to: fetchLastUpdatedTrigger)
            .disposed(by: disposeBag)

        saveCompleteRelay
            .map { _ in ProcessState.saved }
            .bind(to: processStateRelay)
            .disposed(by: disposeBag)

        fetchLastUpdatedTrigger
            .flatMapLatest {
                repository.fetchLastUpdated()
                    .map { date -> String? in
                        if let date = date {
                            return "\(date)"
                        } else {
                            return nil
                        }
                    }
            }
            .bind(to: lastUpdatedRelay)
            .disposed(by: disposeBag)

        clearLocalDataTrigger
            .flatMapLatest {
                repository.clearLocalData()
            }
            .subscribe(onNext: { [weak self] in
                self?.dataStateRelay.accept(.noData)
                self?.lastUpdatedRelay.accept(nil)
                self?.processStateRelay.accept(.cleared)
            })
            .disposed(by: disposeBag)

        clearLocalDataTrigger
            .map { _ in ProcessState.clearing }
            .bind(to: processStateRelay)
            .disposed(by: disposeBag)
    }

    func fetch(id: CompanyInfo.ID) {
        fetchTrigger.accept(id)
    }

    func clear() {
        clearLocalDataTrigger.accept(())
    }
}
