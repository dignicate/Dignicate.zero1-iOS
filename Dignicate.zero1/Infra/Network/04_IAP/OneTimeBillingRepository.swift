//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import StoreKit

final class OneTimeBillingRepository: OneTimeBillingRepositoryProtocol {

    func fetchProducts() -> Single<[String]> {
        Single.create { emitter in
            let request = SKProductsRequestWrapper { (req, res) in
                emitter(.success(res.products.map { "\($0)" }))
            }
            request.start()
            return Disposables.create()
        }
    }
}

final class SKProductsRequestWrapper: NSObject, SKProductsRequestDelegate {

    private let request: SKProductsRequest

    private let eventHandler: ((SKProductsRequest, SKProductsResponse)) -> Void

    init(eventHandler: @escaping ((SKProductsRequest, SKProductsResponse)) -> Void) {
        request = SKProductsRequest()
        self.eventHandler = eventHandler
    }

    func start() {
        request.start()
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        eventHandler((request, response))
    }
}
