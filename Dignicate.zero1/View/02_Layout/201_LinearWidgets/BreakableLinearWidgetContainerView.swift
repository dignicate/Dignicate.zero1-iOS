//
//  Created by Shinichi Watanabe on 2021/12/19.
//  Copyright © 2021 Dignicate,. All rights reserved.
//

import SwiftUI

struct BreakableLinearWidgetContainerView: View {

    fileprivate let tags: [String]

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(tags, id: \.self) { tag in
                self.label(title: tag)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= (d.height + 2)
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= (d.width + 4)
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func label(title: String) -> some View {
        Text(title)
            .font(.system(size: 10))
            .padding(.horizontal, 7)
            .padding(.vertical, 2)
            .foregroundColor(Color.white)
            .background(Color.black)
    }
}

struct BreakableLinearWidgetContainerView_Previews: PreviewProvider {
    static var previews: some View {
        BreakableLinearWidgetContainerView(tags: ["aaa", "bbbb", "cccc", "ddddd", "eeeee", "fffffffffff", "bbbb", "ddddd", "aaaaaa", "bbbb", "cccc", "ddddd", "eee", "ffff", ])
    }
}
