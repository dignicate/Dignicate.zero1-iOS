//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

final class TopViewTableCell: UITableViewCell {

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
