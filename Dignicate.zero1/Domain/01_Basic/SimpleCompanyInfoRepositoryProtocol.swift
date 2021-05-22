//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift

protocol SimpleCompanyInfoRepositoryProtocol {
    func fetch(id: CompanyInfo.ID) -> Single<CompanyInfo>
}
