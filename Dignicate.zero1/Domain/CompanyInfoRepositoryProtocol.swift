//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift

protocol CompanyInfoRepositoryProtocol {
    func fetch(id: CompanyInfo.ID) -> Single<CompanyInfo>
}
