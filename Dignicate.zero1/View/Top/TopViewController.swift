//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

final class TopViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = TopViewModel()

    typealias Section = TopViewModel.ContentStructure.Section

    typealias Item = TopViewModel.ContentStructure.Item

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        navigationItem.title = "Dignicate.zero1"

        tableView.dataSource = self
        tableView.register(R.nib.topViewTableCell, forCellReuseIdentifier: TopViewTableCell.reuseID)
    }

}

extension TopViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.section(for: section)?.title
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(for: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.item(for: indexPath),
              let cell = tableView.dequeueReusableCell(withIdentifier: TopViewTableCell.reuseID, for: indexPath) as? TopViewTableCell else {
            fatalError()
        }
        cell.configure(number: indexPath.row + 1, title: item.title, isEnabled: item.isAvailable)
        return cell
    }
}
