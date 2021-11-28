//
// Created by Shinichi Watanabe on 2021/11/28.
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift

final class OneTimeBillingRepository: NSObject, OneTimeBillingRepositoryProtocol {

    func fetchProducts() -> Single<[String]> {
        Single.just(["a", "b", "c"])
    }
}

import StoreKit

extension OneTimeBillingRepository: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

    }
}
