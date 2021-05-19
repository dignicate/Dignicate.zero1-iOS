//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

struct R {

    private init() {}

    enum color {
        enum topView {
            enum cell {
                enum text {
                    static let enabled = UIColor(named: "top_view_cell_text_enabled")
                    static let disabled = UIColor(named: "top_view_cell_text_disabled")
                }
                enum background {
                    static let enabled = UIColor(named: "top_view_cell_background_enabled")
                    static let disabled = UIColor(named: "top_view_cell_background_disabled")
                }
            }
        }
    }

    enum nib {
        static var topViewTableCell: UINib {
            UINib(nibName: "TopViewTableCell", bundle: nil)
        }
    }
}
