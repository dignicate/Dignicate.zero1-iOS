//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

struct CompanyInfoFetchAndSaveRepositoryMock: CompanyInfoFetchAndSaveRepositoryProtocol {

    enum UserDefaultKey {
        static let companyInfoLastUpdate = "companyInfoLastUpdate"
    }

    private let delaySec: Double

    private var memoryCache: CompanyInfoMemoryCacheDataStore {
        .instance
    }

    init(delaySec: Double) {
        self.delaySec = delaySec
    }

    func fetch(id: CompanyInfo.ID) -> Single<FetchAndSaveDataUseCase.DataSource> {
        if memoryCache.hasMemoryCache(id: id),
           let data = memoryCache.fetch(id: id) {
            return Single.just(.local(companyInfo: data))
        } else {
            return Single.create { observer in
                DispatchQueue.main.asyncAfter(deadline: .now() + delaySec) {
                    let data = CompanyInfo(
                        id: .init(value: 1234),
                        nameJP: "ディグニケート合同会社",
                        nameEN: "Dignicate, LLC",
                        address: "東京都新宿区西新宿３−１−５新宿嘉泉ビル８F",
                        foundationDate: .init(year: 2019, month: 5, day: 20),
                        capital: .jpy(amount: 90000000000000),
                        numberOfEmployees: 29018
                    )
                    observer(.success(.remote(companyInfo: data)))
                }
                return Disposables.create()
            }
        }
    }

    func clearLocalData() -> Single<()> {
        Single.create { observer in
            UserDefaults.standard.removeObject(forKey: UserDefaultKey.companyInfoLastUpdate)
            memoryCache.clear()
            DispatchQueue.main.asyncAfter(deadline: .now() + (delaySec * 2.5)) {
                observer(.success(()))
            }
            return Disposables.create()
        }
    }

    func saveToLocal(companyInfo: CompanyInfo) -> Single<Void> {
        Single.create { observer in
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: UserDefaultKey.companyInfoLastUpdate)
            memoryCache.save(companyInfo: companyInfo)
            DispatchQueue.main.asyncAfter(deadline: .now() + (delaySec * 2)) {
                observer(.success(()))
            }
            return Disposables.create()
        }
    }

    func fetchLastUpdated() -> Single<Date?> {
        Single.create { observer in
            if let stringValue = UserDefaults.standard.string(forKey: UserDefaultKey.companyInfoLastUpdate),
               let doubleValue = Double(stringValue) {
                observer(.success(Date(timeIntervalSince1970: doubleValue)))
            } else {
                observer(.success(nil))
            }
            return Disposables.create()
        }
    }
}
