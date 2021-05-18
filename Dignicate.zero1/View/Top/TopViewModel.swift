//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import Foundation

final class TopViewModel {

    enum ContentStructure {
        static func item(for indexPath: IndexPath) -> Item? {
            section(for: indexPath.section)?.items.first(where: { $0.itemValue == indexPath.row })
        }

        static func section(for section: Int) -> Section? {
            Section.allCases.first(where: { $0.sectionValue == section })
        }

        enum Section: CaseIterable {
            case basic
            var sectionValue: Int {
                switch self {
                case .basic: return 0
                }
            }
            var title: String {
                switch self {
                case .basic: return "Basic"
                }
            }
            fileprivate var items: [Item] {
                switch self {
                case .basic:
                    return [.basicFetch]
                }
            }
        }

        enum Item {
            case basicFetch
            var itemValue: Int {
                switch self {
                case .basicFetch: return 0
                }
            }
            var title: String {
                switch self {
                case .basicFetch: return "Basic API Fetch Pattern"
                }
            }
            var reuseID: String {
                switch self {
                case .basicFetch: return "reuse_id_basic_fetch"
                }
            }
        }
    }

    var numberOfSections: Int {
        ContentStructure.Section.allCases.count
    }

    func numberOfItems(for section: Int) -> Int {
        ContentStructure.section(for: section)?.items.count ?? 0
    }

    func section(for section: Int) -> ContentStructure.Section? {
        ContentStructure.section(for: section)
    }

    func item(for indexPath: IndexPath) -> ContentStructure.Item? {
        ContentStructure.item(for: indexPath)
    }
}
