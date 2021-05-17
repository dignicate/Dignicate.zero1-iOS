//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

final class TopViewTableCell: UITableViewCell {

    @IBOutlet private weak var numberLabel: UILabel!

    @IBOutlet private weak var titleLabel: UILabel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        selectionStyle = .none
        setupUI()
    }

    private func setupUI() {
        // TODO:
    }
}
