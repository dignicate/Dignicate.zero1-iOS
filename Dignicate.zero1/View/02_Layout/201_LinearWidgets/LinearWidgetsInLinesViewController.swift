//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

final class LinearWidgetsInLinesViewController: UIViewController {

    enum Event {
        case didTapCloseButton
    }

    private let eventHandler: (Event) -> Void

    init(eventHandler: @escaping (Event) -> Void) {
        self.eventHandler = eventHandler
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supposed to be called.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapCloseButton))
        navigationItem.leftBarButtonItems = [closeButton]
    }

    @objc private func didTapCloseButton() {
        eventHandler(.didTapCloseButton)
    }
}
