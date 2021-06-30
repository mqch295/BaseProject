//
//  BPNetAPI.swift
//  BPNetKit
//
//  Created by Mqch on 2021/6/30.
//  Copyright © 2021 com.mqch. All rights reserved.
//

import Foundation
import RxSwift
public protocol BPNetAPI {
    var baseUrl: String { get }
    var path: String { get }
    var headers: BPNetHeader { get }
    var method: BPNetMethod { get }
    var authType: BFNetAuthType { get }
}
public extension BPNetAPI {
    var headers: BPNetHeader {
        return BPNetConfig.shared.defaultHeaders
    }
    var authType: BFNetAuthType {
        return BPNetConfig.shared.authType
    }
}
extension BPNetAPI {
    /// 用于处理返回值 Result 为 nil 的请求
    ///
    /// - Parameter target: 请求目标
    /// - Returns: 请求结果
    public func requestResult(_ method: BPNetMethod) -> Completable {
       
        request(method).asCompletable()
    }

    /// 用于处理请求非集合类型，可以调用 mapObject 方法进行 Model 转换
    ///
    /// - Parameter target: 请求目标
    /// - Returns: json对象
    public func requestObjectJson(_ method: BPNetMethod) -> Single<BPNetJSONResponse> {
        request(method).flatMap { json -> Single<BPNetJSONResponse> in
            // swiftlint:disable force_cast
            //.just(json as! JSONResponse)
            if let list = json as? BPNetJSONResponse {
                return Single.just(list)
            } else {
                return Single.just([:])
            }
        }
    }

    ///  用于处理请求集合类型，可以调用 mapArray 方法进行 Model 转换
    ///
    /// - Parameter target: 请求目标
    /// - Returns: json数组对象
    public func requestArrayJson(_ method: BPNetMethod) -> Single<[BPNetJSONResponse]> {
        request(method).flatMap { json -> Single<[BPNetJSONResponse]> in
            // swiftlint:disable force_cast
            //.just(json as! [JSONResponse])
            if let list = json as? [BPNetJSONResponse] {
                return Single.just(list)
            } else {
                return Single.just([])
            }
        }
    }
    private func request(_ method: BPNetMethod) -> Single<Any?> {
        let target = BPNetTask(baseUrl: baseUrl, path: path, headers: headers, method: method)
        return BFNetProvider.shared.request(target)
    }
}
