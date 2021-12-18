//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

final class LinearWidgetsInLinesViewController: UIViewController {

    enum Event {
        case didTapBackButton
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
        setupNavigation()
    }

    private func setupNavigation() {
        let backButton: UIBarButtonItem = {
            let object = UIBarButtonItem(
                title: "",
                style: .plain,
                target: nil,
                action: #selector(self.didTapButtonButton))
            return object
        }()
        navigationItem.backBarButtonItem = backButton
    }

    @objc private func didTapButtonButton(_ sender: AnyObject) {
        eventHandler(.didTapBackButton)
    }
}
