//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

final class FetchAndSaveDataUseCase {

    private let disposeBag = DisposeBag()

    private let fetchTrigger = PublishRelay<CompanyInfo.ID>()

    private let saveTrigger = PublishRelay<(CompanyInfo.ID, CompanyInfo)>()

    private let saveCompleteRelay = PublishRelay<Void>()

    private let lastUpdatedRelay = PublishRelay<String>()

    var saveComplete: Observable<Void> {
        saveCompleteRelay.asObservable()
    }

    init(repository: CompanyInfoFetchAndSaveRepositoryProtocol) {
        fetchTrigger
            .flatMapLatest { id in
                repository
                    .fetch(id: id)
                    .map { (id, $0) }
            }
            .bind(to: saveTrigger)
            .disposed(by: disposeBag)

        fetchTrigger
            .flatMapLatest { _ in
                repository.fetchLastUpdated()
                    .map { "\($0)" }
            }
            .bind(to: lastUpdatedRelay)
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
