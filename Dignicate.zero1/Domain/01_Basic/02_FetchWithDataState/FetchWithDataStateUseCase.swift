//
// Created by Shinichi Watanabe on 2021/05/22.
// Copyright (c) 2021 Dignicate,. All rights reserved.
//

import Foundation

final class FetchWithDataStateUseCase {

    enum DataState {
        case success(data: CompanyInfo)
        case inProgress
        case failure
    }
}
