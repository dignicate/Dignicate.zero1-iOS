//
// Created by Shinichi Watanabe on 2021/11/28.
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift

struct OneTimeBillingRepository: OneTimeBillingRepositoryProtocol {

    func fetchProducts() -> Single<[String]> {
        Single.just(["a", "b", "c"])
    }
}
