//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class OneTimeBillingViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = OneTimeBillingViewModel()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        viewModel.viewDidLoad()
    }
    
    private func setupBinding() {
        viewModel.shouldRefresh
            .emit(onNext: { [weak tableView] _ in
                tableView?.reloadData()
            })
            .disposed(by: disposeBag)
    }

    @IBAction private func didTapFetchDataButton(_ sender: Any) {
        viewModel.didTapFetchDataButton()
    }
}

extension OneTimeBillingViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.productsCount
        return count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        cell.textLabel?.text = viewModel.products(for: indexPath)
        return cell
    }
}
