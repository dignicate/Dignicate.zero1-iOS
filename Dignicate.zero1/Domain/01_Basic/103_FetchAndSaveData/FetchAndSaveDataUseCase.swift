//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

final class FetchAndSaveDataUseCase {

    private let disposeBag = DisposeBag()

    private let fetchTrigger = PublishRelay<CompanyInfo.ID>()

    private let saveTrigger = PublishRelay<CompanyInfo>()

    private let fetchedDataRelay = PublishRelay<DataSource>()

    private let saveCompleteRelay = PublishRelay<Void>()

    private let lastUpdatedRelay = PublishRelay<String>()

    var fetchedData: Observable<CompanyInfo> {
        fetchedDataRelay.map {
            switch $0 {
            case .remote(let data): return data
            case .local(let data): return data
            }
        }
    }

    var saveComplete: Observable<Void> {
        saveCompleteRelay.asObservable()
    }

    var lastUpdated: Observable<String> {
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
            .bind(to: fetchedDataRelay)
            .disposed(by: disposeBag)

        fetchTrigger
            .flatMapLatest { _ in
                repository.fetchLastUpdated()
                    .map { "\($0)" }
            }
            .bind(to: lastUpdatedRelay)
            .disposed(by: disposeBag)

        fetchedDataRelay
            .compactMap {
                switch $0 {
                case .remote(let data): return data
                case .local: return nil
                }
            }
            .bind(to: saveTrigger)
            .disposed(by: disposeBag)

        saveTrigger
            .flatMapLatest {
                repository.save(companyInfo: $0)
            }
            .bind(to: saveCompleteRelay)
            .disposed(by: disposeBag)
    }

    func fetch(id: CompanyInfo.ID) {
        fetchTrigger.accept(id)
    }
}
