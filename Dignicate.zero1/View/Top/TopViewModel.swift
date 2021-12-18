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
            case layout = 1
            case tableView = 2
            case userInput = 3
            case inAppPurchase = 4
//            case swiftUIIntegration

            var title: String {
                switch self {
                case .basic: return "Basic Data Interaction"
                case .layout: return "Layout"
                case .tableView: return "Table View"
                case .userInput: return "User Input"
                case .inAppPurchase: return "In App Purchase"
                }
            }

            fileprivate var items: [Item] {
                switch self {
                case .basic:
                    return [.basicFetch, .fetchWithDataState, .fetchAndSave, .postAndRefresh]
                case .layout:
                    return [.linearWidgetsIntoLines]
                case .tableView:
                    return [.listAndDetail, .pagination]
                case .userInput:
                    return [.simpleValidation, .validateAndAutoCorrect, .storeInputsOverScreens]
                case .inAppPurchase:
                    return [.oneTimeBilling]
                }
            }
        }

        enum Item {
            case basicFetch
            case fetchWithDataState
            case fetchAndSave
            case postAndRefresh
            case linearWidgetsIntoLines
            case listAndDetail
            case pagination
            case simpleValidation
            case validateAndAutoCorrect
            case storeInputsOverScreens
            case oneTimeBilling

            var title: String {
                switch self {
                case .basicFetch: return "Basic fetch over HTTP"
                case .fetchWithDataState: return "Fetch with data state"
                case .fetchAndSave: return "Fetch and save"
                case .postAndRefresh: return "Post data and refresh view"
                case .linearWidgetsIntoLines: return "Linear widgets in lines"
                case .listAndDetail: return "List and detail"
                case .pagination: return "Pagination"
                case .simpleValidation: return "Simple validation"
                case .validateAndAutoCorrect: return "Validate and auto-correct"
                case .storeInputsOverScreens: return "Store inputs over screens"
                case .oneTimeBilling: return "One Time Billing"
                }
            }

            var isAvailable: Bool {
                switch self {
                case .basicFetch, .fetchWithDataState, .fetchAndSave,
                     .linearWidgetsIntoLines,
                     .oneTimeBilling:
                    return true
                case .postAndRefresh, .listAndDetail, .pagination,
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
