//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FetchAndSaveDataViewController: UIViewController {

    private let disposeBag = DisposeBag()

    private let viewModel = FetchAndSaveDataViewModel()

    @IBOutlet private weak var companyNameJPLabel: UILabel!

    @IBOutlet private weak var companyNameENLabel: UILabel!

    @IBOutlet private weak var lastUpdatedLabel: UILabel!

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    private func setupBinding() {
        viewModel.companyNameJP
            .drive(companyNameJPLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.companyNameEN
            .drive(companyNameENLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.lastUpdated
            .drive(lastUpdatedLabel.rx.text)
            .disposed(by: disposeBag)
    }

    @IBAction private func didTapFetchButton(_ sender: Any) {
        viewModel.didTapFetchButton(id: 1234)
    }
}
