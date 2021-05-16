//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

final class TopViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = TopViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        navigationItem.title = "Dignicate.zero1"

        tableView.dataSource = self
    }

}

extension TopViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(section: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        fatalError("tableView(_:cellForRowAt:) has not been implemented")
        UITableViewCell()
    }
}
