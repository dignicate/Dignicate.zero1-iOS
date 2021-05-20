//
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TopViewModel {

    private let disposeBag = DisposeBag()

    private let useCase = TopViewUseCase(repository: CompanyInfoRepositoryMock())

    func viewDidLoad(id: Int) {
        useCase.fetch(id: .init(value: id))
    }
}
