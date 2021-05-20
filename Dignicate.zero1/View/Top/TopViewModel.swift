//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import Foundation
import RxSwift

final class TopViewModel {

    private let disposeBag = DisposeBag()

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
//            case swiftUIIntegration

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
                    return [.listAndDetail, .pagination]
                case .userInput:
                    return [.simpleValidation, .validateAndAutoCorrect, .storeInputsOverScreens]
                }
            }
        }

        enum Item {
            case basicFetch
            case fetchDataAndSaveCache
            case postAndRefresh
            case listAndDetail
            case pagination
            case simpleValidation
            case validateAndAutoCorrect
            case storeInputsOverScreens

            var title: String {
                switch self {
                case .basicFetch: return "Basic fetch over HTTP"
                case .fetchDataAndSaveCache: return "Save fetched data into local device"
                case .postAndRefresh: return "Post data and refresh view"
                case .listAndDetail: return "List and detail"
                case .pagination: return "Pagination"
                case .simpleValidation: return "Simple validation"
                case .validateAndAutoCorrect: return "Validate and auto-correct"
                case .storeInputsOverScreens: return "Store inputs over screens"
                }
            }

            var isAvailable: Bool {
                switch self {
                case .basicFetch:
                    return true
                case .fetchDataAndSaveCache, .postAndRefresh, .listAndDetail, .pagination,
                     .simpleValidation, .validateAndAutoCorrect, .storeInputsOverScreens:
                    return false
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
