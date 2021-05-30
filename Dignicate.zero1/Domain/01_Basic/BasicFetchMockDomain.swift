//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import Foundation

// Easy mock implementation to focus on the sample purpose.
enum BasicFetchMockDomain {
    struct YMD {
        let year: Int
        let month: Int
        let day: Int

        var localizedExpression: String {
            "令和\(year - 2018)年\(month)月\(day)日"
        }
    }

    enum Currency {
        case jpy(amount: Int)
        case usd(amount: Int)

        var localizedExpression: String {
            switch self {
            case .jpy(let amount):
                return "\(amount / 1000000000000)兆円"
            case .usd(let amount):
                return "\(amount / 1000000000000)兆ドル"
            }
        }
    }
}
