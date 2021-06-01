//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

final class FetchAndSaveDataUseCase {

    private let disposeBag = DisposeBag()

    private let fetchTrigger = PublishRelay<CompanyInfo.ID>()

    private let saveTrigger = PublishRelay<CompanyInfo>()

    private let saveCompleteRelay = PublishRelay<Void>()

    private let hasSaveDataRelay = PublishRelay<Bool>()

    var saveComplete: Observable<Void> {
        saveCompleteRelay.asObservable()
    }

    init(repository: CompanyInfoFetchAndSaveRepositoryProtocol) {
        fetchTrigger
            .flatMapLatest { id in
                repository.fetch(id: id)
            }
            .bind(to: saveTrigger)
            .disposed(by: disposeBag)

        fetchTrigger
            .flatMapLatest { _ in
                repository.hasSaveData()
            }
            .bind(to: hasSaveDataRelay)
            .disposed(by: disposeBag)

        saveTrigger
            .flatMapLatest { companyInfo in
                repository.save(companyInfo: companyInfo)
            }
            .bind(to: saveCompleteRelay)
            .disposed(by: disposeBag)
    }

    func fetch(id: CompanyInfo.ID) {
        fetchTrigger.accept(id)
    }
}
