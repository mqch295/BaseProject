//
//  BFNetProvider.swift
//  BPNetKit
//
//  Created by Mqch on 2021/6/30.
//  Copyright © 2021 com.mqch. All rights reserved.
//

import Foundation
import RxMoya
import Moya
import RxSwift
class BFNetProvider: MoyaProvider<BPNetTask> {
    static let shared = BFNetProvider()
    private init() {
        let session = Moya.Session.default
        session.sessionConfiguration.timeoutIntervalForRequest = BPNetConfig.shared.defaultTimeOut
        super.init(session: session, plugins: BPNetConfig.shared.plugins)
    }
}
extension BFNetProvider {
    
    /// 请求数据
    ///
    /// - Parameter target: 请求目标
    /// - Returns: json数组或对象数据
    func request(_ target: BPNetTask) -> Single<Any?> {
        self.rx
            .request(target)
                .filterSuccessfulStatusAndRedirectCodes()
                .mapJSON()
                .flatMap { json -> Single<Any?> in
                    // swiftlint:disable force_cast
                    let data = json as! BPNetJSONResponse
                    guard let code = data["code"] as? Int, let msg = data["msg"] as? String else {
                        return .error(BPNetError.errorJSON)
                    }
                    guard code == 0 else {
                        return .error(BPNetError.detail(code: code, msg: msg))
                    }
                    return Single.just(data["data"])
                }.catchError { error -> PrimitiveSequence<SingleTrait, Any?> in
                    switch error{
                    case is BPNetError:
                        return .error(error)
                    case is MoyaError:
                        guard case let MoyaError.statusCode(response) = error else {
                            return .error(BPNetError.other(error: error))
                        }
                        let statusCode = response.statusCode
                        let error: BPNetError
                        switch statusCode {
                        case 401:
                            error = BPNetError.authFailed
                        case 404:
                            error = BPNetError.notFount
                        default:
                            error = BPNetError.serverInfo(code: statusCode)
                        }
                        return .error(error)
                    default:
                        return .error(BPNetError.other(error: error))
                    }
                }
    }
}
