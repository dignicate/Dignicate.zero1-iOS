//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class BasicFetchAPIViewModel {

    private let disposeBag = DisposeBag()

    private let useCase = BasicFetchAPIUseCase(repository: SimpleCompanyInfoRepositoryMock(delaySec: 2.0))

    var companyNameJP: Driver<String> {
        useCase
            .companyInfo
            .map(\.nameJP)
            .asDriver(onErrorDriveWith: .empty())
    }

    var companyNameEN: Driver<String> {
        useCase
            .companyInfo
            .map(\.nameEN)
            .asDriver(onErrorDriveWith: .empty())
    }

    var address: Driver<String> {
        useCase
            .companyInfo
            .map(\.address)
            .asDriver(onErrorDriveWith: .empty())
    }

    var foundationDate: Driver<String> {
        useCase
            .companyInfo
            .map(\.foundationDate)
            .map { $0.localizedExpression }
            .asDriver(onErrorDriveWith: .empty())
    }

    var capital: Driver<String> {
        useCase
            .companyInfo
            .map(\.capital)
            .map { $0.localizedExpression }
            .asDriver(onErrorDriveWith: .empty())
    }

    var numberOfEmployees: Driver<String> {
        useCase
            .companyInfo
            .map(\.numberOfEmployees)
            .map { "\($0) 名" }
            .asDriver(onErrorDriveWith: .empty())
    }

    func didTapFetchButton(id: Int) {
        useCase.fetch(id: .init(value: id))
    }
}
