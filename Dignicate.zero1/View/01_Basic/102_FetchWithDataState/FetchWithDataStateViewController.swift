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

    @IBOutlet private weak var fetchingIndicator: UIActivityIndicatorView!

    private let disposeBag = DisposeBag()

    private let viewModel = FetchWithDataStateViewModel()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }

    private func setupUI() {
        companyNameJPLabel.text = ""
        companyNameENLabel.text = ""
        addressLabel.text = ""
        foundationDateLabel.text = ""
        capitalLabel.text = ""
        numberOfEmployeesLabel.text = ""
        fetchingIndicator.startAnimating()
        fetchingIndicator.isHidden = true
    }

    private func setupBinding() {
        viewModel.companyNameJP
            .drive(companyNameJPLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.companyNameEN
            .drive(companyNameENLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.address
            .drive(addressLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.foundationDate
            .drive(foundationDateLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.capital
            .drive(capitalLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.numberOfEmployees
            .drive(numberOfEmployeesLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.shouldHideWaitingCircle
            .drive(fetchingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
    }
    @IBAction private func didTapFetchButton(_ sender: Any) {
        viewModel.didTapFetchButton(id: 1234)
    }
}
