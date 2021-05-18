//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import Foundation

final class TopViewModel {

    enum ContentStructure {
        static func item(for indexPath: IndexPath) -> Item? {
            section(for: indexPath.section)?.items[indexPath.row]
        }

        static func section(for section: Int) -> Section? {
            Section.allCases.first(where: { $0.rawValue == section })
        }

        enum Section: Int, CaseIterable {
            case basic = 0
            case tableView = 1
            case userInput = 2
//            case swiftUIIntegration = 2

            var title: String {
                switch self {
                case .basic: return "Basic Data Interaction"
                case .tableView: return "Table View"
                case .userInput: return "User Input"
                }
            }

            fileprivate var items: [Item] {
                switch self {
                case .basic:
                    return [.basicFetch, .fetchDataAndSaveCache, .postAndRefresh]
                case .tableView:
                    return []
                case .userInput:
                    return []
                }
            }
        }

        enum Item: Int {
            case basicFetch = 0
            case fetchDataAndSaveCache = 1
            case postAndRefresh = 2
            case listAndDetail = 3
            case pagination = 4

            var title: String {
                switch self {
                case .basicFetch: return "Basic fetch over HTTP"
                case .fetchDataAndSaveCache: return "Save fetched data into local device"
                case .postAndRefresh: return "Post data and refresh view"
                case .listAndDetail: return "List and detail"
                case .pagination: return "Pagination"
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
