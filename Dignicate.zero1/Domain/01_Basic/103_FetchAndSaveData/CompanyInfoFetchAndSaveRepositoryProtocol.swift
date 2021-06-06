//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

protocol CompanyInfoFetchAndSaveRepositoryProtocol {
    func fetch(id: CompanyInfo.ID) -> Single<FetchAndSaveDataUseCase.DataSource>
    func fetchLastUpdated() -> Single<Date?>
    func saveToLocal(companyInfo: CompanyInfo) -> Single<Void>
    func clearLocalData() -> Single<Void>
}
