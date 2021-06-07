//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FetchAndSaveDataViewModel {

    private let disposeBag = DisposeBag()

    private let useCase = FetchAndSaveDataUseCase(repository: CompanyInfoFetchAndSaveRepositoryMock(delaySec: 0.2))

    var companyNameJP: Driver<String> {
        useCase
            .dataState
            .map { $0.data?.nameJP ?? "" }
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    var companyNameEN: Driver<String> {
        useCase
            .dataState
            .map { $0.data?.nameEN ?? "" }
            .startWith("")
            .asDriver(onErrorDriveWith: .empty())
    }

    var lastUpdated: Driver<String> {
        Observable.combineLatest(
                useCase.dataState,
                useCase.lastUpdated)
            .map { _, lastUpdated in
                lastUpdated ?? ""
            }
            .startWith("")
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
    }

    var dataSourceName: Driver<String> {
        useCase.dataState
            .map {
                switch $0 {
                case .remote: return "リモート（モック）"
                case .local: return "ローカル保存"
                case .noData: return ""
                }
            }
            .startWith("")
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
    }

    var shouldEnableClearButton: Driver<Bool> {
        useCase.lastUpdated
            .map { $0 != nil }
            .startWith(false)
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
    }

    func didTapFetchButton(id: Int) {
        useCase.fetch(id: CompanyInfo.ID(value: id))
    }

    func didTapClearButton() {
        useCase.clear()
    }
}
