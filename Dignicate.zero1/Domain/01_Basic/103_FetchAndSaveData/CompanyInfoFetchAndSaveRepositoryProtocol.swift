//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

protocol CompanyInfoFetchAndSaveRepositoryProtocol {
    func fetch(id: CompanyInfo.ID) -> Single<FetchAndSaveDataUseCase.DataSource>
    func fetchLastUpdated() -> Single<Date?>
    func save(companyInfo: CompanyInfo) -> Single<Void>
    func clear() -> Single<Void>
}
