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

    private let saveCompleteRelay = PublishRelay<Void>()

    private let lastUpdatedRelay = PublishRelay<String?>()

    var dataState: Observable<DataState> {
        dataStateRelay
            .asObservable()
    }

    var saveComplete: Observable<Void> {
        saveCompleteRelay.asObservable()
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

    init(repository: CompanyInfoFetchAndSaveRepositoryProtocol) {
        fetchTrigger
            .flatMapLatest { id in
                repository.fetch(id: id)
            }
            .bind(to: dataStateRelay)
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

        dataStateRelay
            .filter {
                switch $0 {
                case .remote, .noData: return false
                case .local: return true
                }
            }
            .map { _ in () }
            .bind(to: fetchLastUpdatedTrigger)
            .disposed(by: disposeBag)

        saveTrigger
            .flatMapLatest {
                repository.saveToLocal(companyInfo: $0)
            }
            .bind(to: saveCompleteRelay)
            .disposed(by: disposeBag)

        saveCompleteRelay
            .bind(to: fetchLastUpdatedTrigger)
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
            })
            .disposed(by: disposeBag)
    }

    func fetch(id: CompanyInfo.ID) {
        fetchTrigger.accept(id)
    }

    func clear() {
        clearLocalDataTrigger.accept(())
    }
}
