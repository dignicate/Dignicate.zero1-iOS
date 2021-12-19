//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import SwiftUI

extension View {

    var uiView: UIView {
        let uiView = UIHostingController(rootView: self).view!
        uiView.backgroundColor = .clear
        return uiView
    }

    @discardableResult func snap(to parent: UIView) -> Self {
        let uiView = self.uiView
        parent.addSubview(uiView)
        uiView.snap(to: parent)
        return self
    }
}
