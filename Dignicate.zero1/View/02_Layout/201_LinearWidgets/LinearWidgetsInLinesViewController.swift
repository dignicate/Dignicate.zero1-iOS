//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit

final class LinearWidgetsInLinesViewController: UIViewController {

    @IBOutlet private weak var widgetContainerViewHost: UIView!

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
        setupUI()
        setupNavigation()
    }

    private func setupUI() {
         BreakableLinearWidgetContainerView(
            tags: ["古典", "経済学", "宇宙物理学", "世界史", "シンギュラリティー", "80億年後の地球",  "ソマリア", "どうぶつの森", "ローマ帝国"]
        )
        .snap(to: widgetContainerViewHost)
    }

    private func setupNavigation() {
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapCloseButton))
        navigationItem.leftBarButtonItems = [closeButton]
    }

    @objc private func didTapCloseButton() {
        eventHandler(.didTapCloseButton)
    }
}
