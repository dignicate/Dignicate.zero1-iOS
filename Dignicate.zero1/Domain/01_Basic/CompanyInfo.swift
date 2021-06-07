//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import Foundation

struct CompanyInfo {
    let id: ID
    let nameJP: String
    let nameEN: String
    let address: String
    let foundationDate: BasicFetchMockDomain.YMD
    let capital: BasicFetchMockDomain.Currency
    let numberOfEmployees: Int

    struct ID: Hashable {
        let value: Int
    }
}
