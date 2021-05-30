//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

struct SimpleCompanyInfoRepositoryMock: SimpleCompanyInfoRepositoryProtocol {

    private let delayMs: Double

    init(delayMs: Double) {
        self.delayMs = delayMs
    }

    func fetch(id: CompanyInfo.ID) -> Single<CompanyInfo> {
        Single.create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + delayMs) {
                let data = CompanyInfo(
                    nameJP: "ディグニケート合同会社",
                    nameEN: "Dignicate, LLC",
                    address: "東京都新宿区西新宿３−１−５新宿嘉泉ビル８F",
                    foundationDate: .init(year: 2019, month: 5, day: 20),
                    capital: .jpy(amount: 90000000000000),
                    numberOfEmployees: 29018
                )
                observer(.success(data))
            }
            return Disposables.create()
        }
    }
}
