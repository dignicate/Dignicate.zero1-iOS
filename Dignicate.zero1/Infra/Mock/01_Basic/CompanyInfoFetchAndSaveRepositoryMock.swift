//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

struct CompanyInfoFetchAndSaveRepositoryMock: CompanyInfoFetchAndSaveRepositoryProtocol {

    enum UserDefaultKey {
        static let companyInfoLastUpdate = "companyInfoLastUpdate"
    }

    private let delayMs: Double

    private var memoryCache: CompanyInfoMemoryCacheDataStore {
        .instance
    }

    init(delayMs: Double) {
        self.delayMs = delayMs
    }

    func fetch(id: CompanyInfo.ID) -> Single<CompanyInfo> {
        if memoryCache.hasMemoryCache(id: id),
           let data = memoryCache.fetch(id: id) {
            return Single.just(data)
        } else {
            // WARNING: This is NOT an appropriate way I presume.
            // I did like below because it is mare a MOCK.
            return SimpleCompanyInfoRepositoryMock(delayMs: delayMs).fetch(id: id)
        }
    }

    func save(id: CompanyInfo.ID, companyInfo: CompanyInfo) -> Single<()> {
        Single.just(memoryCache.save(id: id, companyInfo: companyInfo))
    }

    func hasSaveData() -> Single<Bool> {
        fatalError("hasSaveData() has not been implemented")
    }
}
