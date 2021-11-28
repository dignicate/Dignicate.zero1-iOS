//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class OneTimeBillingViewModel {

    private let useCase = OneTimeBillingUseCase(repository: OneTimeBillingRepository())

    func viewDidLoad() {
        useCase.fetchProducts()
    }
}
