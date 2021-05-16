//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import Foundation

final class TopViewModel {

    enum ContentStructure {
        enum Section: CaseIterable {
            case basic
            var value: Int {
                switch self {
                case .basic: return 0
                }
            }
            var title: String {
                switch self {
                case .basic: return "Basic"
                }
            }
            var items: [Item] {
                switch self {
                case .basic:
                    return [.basicFetch]
                }
            }
            static func from(section: Int) -> Section? {
                allCases.first(where: { $0.value == section })
            }
        }

        enum Item {
            case basicFetch
            var value: Int {
                switch self {
                case .basicFetch: return 0
                }
            }
        }
    }

    var numberOfSections: Int {
        ContentStructure.Section.allCases.count
    }

    func numberOfItems(section: Int) -> Int {
        ContentStructure.Section.from(section: section)?.items.count ?? 0
    }

    func section(for section: Int) -> ContentStructure.Section? {
        ContentStructure.Section.from(section: section)
    }
}
