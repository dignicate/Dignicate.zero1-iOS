//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift

final class BasicFetchAPIViewController: UIViewController {

//    @IBOutlet private weak var companyNameJPLabel: UILabel!
//
//    @IBOutlet private weak var companyNameENLabel: UILabel!
//
//    @IBOutlet private weak var addressLabel: UILabel!
//
//    @IBOutlet private weak var foundationDateLabel: UILabel!
//
//    @IBOutlet private weak var capitalLabel: UILabel!
//
//    @IBOutlet private weak var numberOfEmployeesLabel: UILabel!

    private let disposeBag = DisposeBag()

    private let viewModel = BasicFetchAPIViewModel()

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
//        companyNameJPLabel.text = ""
//        companyNameENLabel.text = ""
//        addressLabel.text = ""
//        foundationDateLabel.text = ""
//        capitalLabel.text = ""
//        numberOfEmployeesLabel.text = ""
    }

    private func setupBinding() {
//        viewModel.companyNameJP
//            .asObservable()
//            .bind(to: companyNameJPLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.companyNameEN
//            .asObservable()
//            .bind(to: companyNameENLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.address
//            .asObservable()
//            .bind(to: addressLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.foundationDate
//            .asObservable()
//            .bind(to: foundationDateLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.capital
//            .asObservable()
//            .bind(to: capitalLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.numberOfEmployees
//            .asObservable()
//            .bind(to: numberOfEmployeesLabel.rx.text)
//            .disposed(by: disposeBag)
    }

//    @IBAction private func didTapFetchButton(_ sender: Any) {
//        viewModel.didTapFetchButton(id: 1234)
//    }

}
