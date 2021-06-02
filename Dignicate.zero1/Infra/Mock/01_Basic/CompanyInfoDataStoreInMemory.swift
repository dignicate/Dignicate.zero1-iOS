//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import Foundation

final class CompanyInfoMemoryCacheDataStore {

    static let instance = CompanyInfoMemoryCacheDataStore()

    private init() {}

    private var memoryCache = [CompanyInfo.ID: CompanyInfo]()

    func hasMemoryCache(id: CompanyInfo.ID) -> Bool {
        memoryCache[id] != nil
    }

    func fetch(id: CompanyInfo.ID) -> CompanyInfo? {
        memoryCache[id]
    }

    func save(id: CompanyInfo.ID, companyInfo: CompanyInfo) -> Void {
        memoryCache[id] = companyInfo
    }
}
