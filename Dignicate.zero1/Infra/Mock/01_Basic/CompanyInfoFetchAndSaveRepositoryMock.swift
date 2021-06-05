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

    func fetch(id: CompanyInfo.ID) -> Single<FetchAndSaveDataUseCase.DataSource> {
        if memoryCache.hasMemoryCache(id: id),
           let data = memoryCache.fetch(id: id) {
            return Single.just(.local(companyInfo: data))
        } else {
            // WARNING: This is NOT an appropriate way I presume.
            // I did like below because it is mare a MOCK.
            return SimpleCompanyInfoRepositoryMock(delayMs: delayMs)
                .fetch(id: id)
                .map { .remote(companyInfo: $0) }
        }
    }

    func save(id: CompanyInfo.ID, companyInfo: CompanyInfo) -> Single<Void> {
        Single.create { observer in
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: UserDefaultKey.companyInfoLastUpdate)
            observer(.success(
                memoryCache.save(id: id, companyInfo: companyInfo)
            ))
            return Disposables.create()
        }
    }

    func fetchLastUpdated() -> Single<Date> {
        Single.create { observer in
            let value = UserDefaults.standard.double(forKey: UserDefaultKey.companyInfoLastUpdate)
            observer(.success(Date(timeIntervalSince1970: value)))
            return Disposables.create()
        }
    }
}
