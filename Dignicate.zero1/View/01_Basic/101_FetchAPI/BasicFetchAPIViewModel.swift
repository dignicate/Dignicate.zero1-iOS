//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class BasicFetchAPIViewModel {

    private let disposeBag = DisposeBag()

    private let useCase = BasicFetchAPIUseCase(repository: SimpleCompanyInfoRepositoryMock(delayMs: 2.0))

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
            .compactMap { $0.localizedExpression }
            .asDriver(onErrorDriveWith: .empty())
    }

    var capital: Driver<String> {
        useCase
            .companyInfo
            .map(\.capital)
            .compactMap { $0.localizedExpression }
            .asDriver(onErrorDriveWith: .empty())
    }

    var numberOfEmployees: Driver<String> {
        useCase
            .companyInfo
            .map(\.numberOfEmployees)
            .compactMap { MockMethods.convertNumberOfEmployeesIntoJapaneseExpression(number: $0) }
            .asDriver(onErrorDriveWith: .empty())
    }

    func didTapFetchButton(id: Int) {
        useCase.fetch(id: .init(value: id))
    }
}

/// MARK: - Mock methods.

/// As a mock, this simply returns constant values to imitate the conversion process,
/// instead of real calculation.
fileprivate struct MockMethods {
    private init() {}
    static func convertDateIntoJavaneseExpression(date: String) -> String {
        "令和元年５月２０日"
    }
    static func convertCapitalIntoJapaneseExpression(capital: Int) -> String {
        "90兆円"
    }
    static func convertNumberOfEmployeesIntoJapaneseExpression(number: Int) -> String {
        "\(number) 名"
    }
}
