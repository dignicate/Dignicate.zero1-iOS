//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

final class OneTimeBillingViewController: UIViewController {

    private let viewModel = OneTimeBillingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
