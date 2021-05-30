//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import Foundation

struct CompanyInfo {
    let nameJP: String
    let nameEN: String
    let address: String
    let foundationDate: BasicFetchMockDomain.YMD
    let capital: BasicFetchMockDomain.Currency
    let numberOfEmployees: Int

    struct ID {
        let value: Int
    }
}
