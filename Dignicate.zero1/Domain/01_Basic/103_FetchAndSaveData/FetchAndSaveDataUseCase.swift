//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

final class FetchAndSaveDataUseCase {

    private let disposeBag = DisposeBag()

    private let fetchTrigger = PublishRelay<CompanyInfo.ID>()

    private let saveTrigger = PublishRelay<(CompanyInfo.ID, CompanyInfo)>()

    private let fetchedDataRelay = PublishRelay<(CompanyInfo.ID, DataSource)>()

    private let saveCompleteRelay = PublishRelay<Void>()

    private let lastUpdatedRelay = PublishRelay<String>()

    var fetchedData: Observable<CompanyInfo> {
        fetchedDataRelay.map { id, dataSource in
            switch dataSource {
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
                    .map { (id, $0) }
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
            .compactMap { id, data in
                switch data {
                case .remote(let data): return (id, data)
                case .local: return nil
                }
            }
            .bind(to: saveTrigger)
            .disposed(by: disposeBag)

        saveTrigger
            .flatMapLatest { id, companyInfo in
                repository.save(id: id, companyInfo: companyInfo)
            }
            .bind(to: saveCompleteRelay)
            .disposed(by: disposeBag)
    }

    func fetch(id: CompanyInfo.ID) {
        fetchTrigger.accept(id)
    }
}
