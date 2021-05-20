//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift

struct CompanyInfoRepositoryMock: CompanyInfoRepositoryProtocol {
    func fetch(id: CompanyInfo.ID) -> Single<CompanyInfo> {
        fatalError("fetch(id:) has not been implemented")
    }
}
