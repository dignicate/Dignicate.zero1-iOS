//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FetchWithDataStateViewController: UIViewController {

    @IBOutlet private weak var companyNameJPLabel: UILabel!

    @IBOutlet private weak var companyNameENLabel: UILabel!

    @IBOutlet private weak var addressLabel: UILabel!

    @IBOutlet private weak var foundationDateLabel: UILabel!

    @IBOutlet private weak var capitalLabel: UILabel!

    @IBOutlet private weak var numberOfEmployeesLabel: UILabel!

    private let disposeBag = DisposeBag()

    private let viewModel = FetchWithDataStateViewModel()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction private func didTapFetchButton(_ sender: Any) {
//        viewModel.didTapFetchButton(id: 1234)
    }
}
