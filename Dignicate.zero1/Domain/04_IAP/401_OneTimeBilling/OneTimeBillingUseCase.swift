//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay
import StoreKit

final class OneTimeBillingUseCase {

    private let disposeBag = DisposeBag()

    private let fetchProductsTrigger = PublishRelay<Void>()

    private let productsRelay = PublishRelay<[String]>()

    init(repository: OneTimeBillingRepositoryProtocol) {
        fetchProductsTrigger
            .flatMap { _ in
                repository.fetchProducts()
            }
            .bind(to: productsRelay)
            .disposed(by: disposeBag)
    }

    func fetchProducts() {
        fetchProductsTrigger.accept(())
    }
}
