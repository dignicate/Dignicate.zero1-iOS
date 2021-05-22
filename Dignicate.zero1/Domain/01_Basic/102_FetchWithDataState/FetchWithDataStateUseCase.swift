//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import RxSwift
import RxRelay

final class FetchWithDataStateUseCase {

    enum DataState {
        case success(data: CompanyInfo)
        case inProgress
        case failure
    }

    private let disposeBag = DisposeBag()

    private let fetchTrigger = PublishRelay<CompanyInfo.ID>()

    private let companyInfoDataStateRelay = PublishRelay<DataState>()

    var companyInfo: Observable<CompanyInfo> {
        companyInfoDataStateRelay
            .compactMap {
                switch $0 {
                case .success(let data):
                    return data
                case .inProgress, .failure:
                    return nil
                }
            }
            .asObservable()
    }

    var isInProgress: Observable<Bool> {
        companyInfoDataStateRelay
            .map {
                switch $0 {
                case .inProgress:
                    return true
                case .success, .failure:
                    return false
                }
            }
            .distinctUntilChanged()
            .asObservable()
    }

    var isFailure: Observable<Bool> {
        companyInfoDataStateRelay
            .map {
                switch $0 {
                case .failure:
                    return true
                case .success, .inProgress:
                    return false
                }
            }
            .distinctUntilChanged()
            .asObservable()
    }

    init(repository: SimpleCompanyInfoRepositoryProtocol) {
        fetchTrigger
            .flatMapLatest { id in
                repository.fetch(id: id)
            }
            .map { data in
                DataState.success(data: data)
            }
            .bind(to: companyInfoDataStateRelay)
            .disposed(by: disposeBag)
    }

    func fetch(id: CompanyInfo.ID) {
        companyInfoDataStateRelay.accept(.inProgress)
        fetchTrigger.accept(id)
    }
}
