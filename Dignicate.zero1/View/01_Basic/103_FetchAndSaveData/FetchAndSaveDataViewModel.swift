//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FetchAndSaveDataViewModel {

    private let disposeBag = DisposeBag()

    private let useCase = FetchAndSaveDataUseCase(repository: CompanyInfoFetchAndSaveRepositoryMock(delaySec: 1.8))

    var companyNameJP: Driver<String> {
        useCase
            .fetchedData
            .map(\.nameJP)
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    var companyNameEN: Driver<String> {
        useCase
            .fetchedData
            .map(\.nameEN)
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    var lastUpdated: Driver<String> {
        Observable.combineLatest(
                useCase.fetchedData,
                useCase.lastUpdated.startWith(""))
            .map { _, lastUpdated in
                lastUpdated
            }
            .startWith("")
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
    }

    func didTapFetchButton(id: Int) {
        useCase.fetch(id: CompanyInfo.ID(value: id))
    }
}
