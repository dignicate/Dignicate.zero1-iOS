//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift

protocol CompanyInfoFetchAndSaveRepositoryProtocol {
    func fetch(id: CompanyInfo.ID) -> Single<CompanyInfo>
    func save(companyInfo: CompanyInfo) -> Single<Void>
    func hasSaveData() -> Single<Bool>
}
