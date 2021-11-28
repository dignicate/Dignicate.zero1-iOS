//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import StoreKit

protocol OneTimeBillingRepositoryProtocol {
    func fetchProducts() -> Single<[String]>
}
