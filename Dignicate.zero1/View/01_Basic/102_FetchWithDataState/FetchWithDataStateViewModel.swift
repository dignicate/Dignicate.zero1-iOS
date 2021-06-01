//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FetchWithDataStateViewModel {

    private let disposeBag = DisposeBag()

    private let useCase = FetchWithDataStateUseCase(repository: SimpleCompanyInfoRepositoryMock(delayMs: 2.5))

    var companyNameJP: Driver<String> {
        useCase
            .companyInfo
            .map(\.nameJP)
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    var companyNameEN: Driver<String> {
        useCase
            .companyInfo
            .map(\.nameEN)
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    var address: Driver<String> {
        useCase
            .companyInfo
            .map(\.address)
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    var foundationDate: Driver<String> {
        useCase
            .companyInfo
            .map(\.foundationDate)
            .compactMap { $0.localizedExpression }
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    var capital: Driver<String> {
        useCase
            .companyInfo
            .map(\.capital)
            .compactMap { $0.localizedExpression }
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    var numberOfEmployees: Driver<String> {
        useCase
            .companyInfo
            .map(\.numberOfEmployees)
            .compactMap { "\($0) 名" }
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    var shouldHideWaitingCircle: Driver<Bool> {
        useCase
            .isInProgress
            .map { !$0 }
            .startWith(true)
            .asDriver(onErrorDriveWith: .empty())
    }

    func didTapFetchButton(id: Int) {
        useCase.fetch(id: .init(value: id))
    }
}
