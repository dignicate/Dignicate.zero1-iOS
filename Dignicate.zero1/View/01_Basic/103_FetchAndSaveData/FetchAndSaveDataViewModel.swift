//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FetchAndSaveDataViewModel {

    private let disposeBag = DisposeBag()

    private let useCase = FetchAndSaveDataUseCase(repository: CompanyInfoFetchAndSaveRepositoryMock(delayMs: 1800))

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
        useCase
            .lastUpdated
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    func didTapFetchButton(id: Int) {
        useCase.fetch(id: CompanyInfo.ID(value: id))
    }
}
