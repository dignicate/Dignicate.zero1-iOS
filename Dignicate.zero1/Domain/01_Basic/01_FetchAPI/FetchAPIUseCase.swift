//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

final class FetchAPIUseCase {

    private let disposeBag = DisposeBag()

    private let fetchTrigger = PublishRelay<CompanyInfo.ID>()

    private let companyInfoRelay = PublishRelay<CompanyInfo>()

    var companyInfo: Observable<CompanyInfo> {
        companyInfoRelay.asObservable()
    }

    init(repository: SimpleCompanyInfoRepositoryProtocol) {
        fetchTrigger
            .flatMapLatest { id in
                repository.fetch(id: id)
            }
            .bind(to: companyInfoRelay)
            .disposed(by: disposeBag)
    }

    func fetch(id: CompanyInfo.ID) {
        fetchTrigger.accept(id)
    }
}
