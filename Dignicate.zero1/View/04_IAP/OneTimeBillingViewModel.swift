//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class OneTimeBillingViewModel {

    private let useCase = OneTimeBillingUseCase(repository: OneTimeBillingRepository())

    var shouldRefresh: Signal<Void> {
        useCase
            .products
            .map { _ in }
            .asSignal(onErrorSignalWith: .empty())
    }

    var productsCount: Int {
        useCase
            .productsValue
            .count
    }

    func viewDidLoad() {
        // Do nothing.
    }

    func didTapFetchDataButton() {
        useCase.fetchProducts()
    }

    func products(for indexPath: IndexPath) -> String {
        useCase.productsValue[indexPath.item]
    }
}
