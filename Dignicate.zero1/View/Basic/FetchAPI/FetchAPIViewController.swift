//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

final class FetchAPIViewController: UIViewController {

    @IBOutlet private weak var companyNameJPLabel: UILabel!

    @IBOutlet private weak var companyNameENLabel: UILabel!

    @IBOutlet private weak var addressLabel: UILabel!

    @IBOutlet private weak var foundationDateLabel: UILabel!

    @IBOutlet private weak var capitalLabel: UILabel!

    @IBOutlet private weak var numberOfEmployeesLabel: UILabel!

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        companyNameJPLabel.text = ""
        companyNameENLabel.text = ""
        addressLabel.text = ""
        foundationDateLabel.text = ""
        capitalLabel.text = ""
        numberOfEmployeesLabel.text = ""
    }

    @IBAction private func didTapFetchButton(_ sender: Any) {
        print("FETCH")
    }

}
