//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FetchAndSaveDataViewModel {

    private let disposeBag = DisposeBag()

    private let useCase = FetchAndSaveDataUseCase(repository: CompanyInfoFetchAndSaveRepositoryMock(delaySec: 0.8))

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

    var dataState: Driver<String> {
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

    var processState: Driver<String> {
        useCase.processState
            .map {
                switch $0 {
                case .noProcess: return "初期状態"
                case .fetching: return "取得中"
                case .fetchedLocally: return "端末から取得"
                case .saving: return "内部保存中"
                case .saved: return "保存完了"
                case .clearing: return "消去中"
                case .cleared: return "消去完了"
                }
            }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
    }

    var shouldEnableClearButton: Driver<Bool> {
        useCase.processState
            .map { $0.isClearAvailable }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
    }

    var shouldEnableFetchButton: Driver<Bool> {
        useCase.processState
            .map { $0.isFetchAvailable }
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
