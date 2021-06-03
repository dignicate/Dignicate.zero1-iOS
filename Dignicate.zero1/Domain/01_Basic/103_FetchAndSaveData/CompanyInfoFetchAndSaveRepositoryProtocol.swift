//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

protocol CompanyInfoFetchAndSaveRepositoryProtocol {
    func fetch(id: CompanyInfo.ID) -> Single<CompanyInfo>
    func save(id: CompanyInfo.ID, companyInfo: CompanyInfo) -> Single<Void>
    func fetchLastUpdated() -> Single<Date>
}
