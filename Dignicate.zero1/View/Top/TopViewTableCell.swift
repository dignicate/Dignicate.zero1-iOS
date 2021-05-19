//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

final class TopViewTableCell: UITableViewCell {

    @IBOutlet private weak var numberLabel: UILabel!

    @IBOutlet private weak var titleLabel: UILabel!

    static let reuseID = "reuse_id_top_view_table_cell"

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        selectionStyle = .none
    }

    func configure(number: Int, title: String, isEnabled: Bool) {
        numberLabel.text = "\(number)"
        titleLabel.text = title
        if isEnabled {
            titleLabel.textColor = R.color.topView.cell.text.enabled
            backgroundColor = R.color.topView.cell.background.enabled
        } else {
            titleLabel.textColor = R.color.topView.cell.text.disabled
            backgroundColor = R.color.topView.cell.background.disabled
        }
    }
}
