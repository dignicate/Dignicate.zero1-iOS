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

    private let companyInfoRelay = PublishRelay<DataSource>()

    private let saveCompleteRelay = PublishRelay<Void>()

    private let clearCompleteRelay = PublishRelay<Void>()

    private let lastUpdatedRelay = PublishRelay<String?>()

    var companyInfo: Observable<CompanyInfo> {
        companyInfoRelay.compactMap {
            switch $0 {
            case .remote(let data): return data
            case .local(let data): return data
            }
        }
    }

    var saveComplete: Observable<Void> {
        saveCompleteRelay.asObservable()
    }

    var clearComplete: Observable<Void> {
        clearCompleteRelay.asObservable()
    }

    var lastUpdated: Observable<String?> {
        lastUpdatedRelay.asObservable()
    }

    enum DataSource {
        case remote(companyInfo: CompanyInfo)
        case local(companyInfo: CompanyInfo)
    }

    init(repository: CompanyInfoFetchAndSaveRepositoryProtocol) {
        fetchTrigger
            .flatMapLatest { id in
                repository.fetch(id: id)
            }
            .bind(to: companyInfoRelay)
            .disposed(by: disposeBag)

        companyInfoRelay
            .compactMap {
                switch $0 {
                case .remote(let data): return data
                case .local: return nil
                }
            }
            .bind(to: saveTrigger)
            .disposed(by: disposeBag)

        companyInfoRelay
            .filter {
                switch $0 {
                case .remote: return false
                case .local: return true
                }
            }
            .map { _ in () }
            .bind(to: fetchLastUpdatedTrigger)
            .disposed(by: disposeBag)

        saveTrigger
            .flatMapLatest {
                repository.save(companyInfo: $0)
            }
            .bind(to: saveCompleteRelay)
            .disposed(by: disposeBag)

        saveCompleteRelay
            .bind(to: fetchLastUpdatedTrigger)
            .disposed(by: disposeBag)

        fetchLastUpdatedTrigger
            .flatMapLatest {
                repository.fetchLastUpdated()
                    .map { "\($0)" }
            }
            .bind(to: lastUpdatedRelay)
            .disposed(by: disposeBag)

        clearLocalDataTrigger
            .flatMapLatest {
                repository.clear()
            }
            .bind(to: clearCompleteRelay)
            .disposed(by: disposeBag)
    }

    func fetch(id: CompanyInfo.ID) {
        fetchTrigger.accept(id)
    }

    func clear() {
        clearLocalDataTrigger.accept(())
    }
}
