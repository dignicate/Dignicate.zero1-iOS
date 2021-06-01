//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FetchAndSaveDataViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet private weak var companyNameJPLabel: UILabel!

    @IBOutlet private weak var companyNameENLabel: UILabel!

    @IBOutlet private weak var lastUpdatedLabel: UILabel!



    @IBAction private func didTapFetchButton(_ sender: Any) {
    }
}
