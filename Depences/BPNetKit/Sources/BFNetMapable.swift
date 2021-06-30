//
//  BFNetMapable.swift
//  BPNetKit
//
//  Created by Mqch on 2021/6/30.
//  Copyright © 2021 com.mqch. All rights reserved.
//

import Foundation
import RxSwift
public extension PrimitiveSequence where Trait == SingleTrait, Element == BPNetJSONResponse {
    /// 将 JSONResult 转换为 Model
    /// - Parameter type: Model 类型
    /// - Parameter extKeyPath: 扩展节点
    func mapObject<T: Codable>(_: T.Type, extKeyPath: String? = nil) -> Single<T> {
        flatMap { response -> Single<T> in
            let result: Result<T, BPNetError>
            if extKeyPath == nil {
                result = self.jsonCovertModel(json: response)
            } else {
                result = self.jsonCovertModel(json: response[extKeyPath!]!)
            }
            switch result {
            case let .success(models):
                return .just(models)
            case let .failure(error):
                return .error(error)
            }
        }
    }

    /// 将 JSONResult 内某个字段内容转换为 ModelArray
    /// - Parameter type: Model 类型
    /// - Parameter extKeyPath: 扩展节点
    func mapArray<T: Codable>(_: T.Type, extKeyPath: String? = nil) -> Single<[T]> {
        flatMap { response -> Single<[T]> in
            let result: Result<[T], BPNetError>
            if extKeyPath == nil {
                result = self.jsonArrayCovertModelArray(jsonArray: response)
            } else {
                result = self.jsonArrayCovertModelArray(jsonArray: response[extKeyPath!]!)
            }
            switch result {
            case let .success(models):
                return .just(models)
            case let .failure(error):
                return .error(error)
            }
        }
    }
}

public extension PrimitiveSequence where Trait == SingleTrait, Element == [BPNetJSONResponse] {
    //// 将 JSONArray 转换为 ModelArray
    /// - Parameter type: Model 类型
    func mapArray<T: Codable>(_: T.Type) -> Single<[T]> {
        flatMap { response -> Single<[T]> in
            let result: Result<[T], BPNetError> = self.jsonArrayCovertModelArray(jsonArray: response)
            switch result {
            case let .success(models):
                return .just(models)
            case let .failure(error):
                return .error(error)
            }
        }
    }
}

private extension PrimitiveSequence where Trait == SingleTrait {
    func jsonArrayCovertModelArray<T: Codable>(jsonArray: Any) -> Result<[T], BPNetError> {
        // 创建解析器
        let decoder = JSONDecoder()
        // 解析器将 SnakeType 转化为 HumpType
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // 判断是否为 JSON 格式
        guard JSONSerialization.isValidJSONObject(jsonArray) else {
            return .failure(.errorJSON)
        }
        do {
            // 将 JSON 转为 JSONDate
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
            // 解析 JSONData 到目标
            let models = try decoder.decode([T].self, from: jsonData)
            return .success(models)
        } catch {
            return .failure(.modelMapFailed(error: error))
        }
    }

    func jsonCovertModel<T: Codable>(json: Any) -> Result<T, BPNetError> {
        // 创建解析器
        let decoder = JSONDecoder()
        // 解析器将 SnakeType 转化为 HumpType
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // 判断是否为 JSON 格式
        guard JSONSerialization.isValidJSONObject(json) else {
            return .failure(.errorJSON)
        }
        do {
            // 将 JSON 转为 JSONDate
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            // 解析 JSONData 到目标
            let models = try decoder.decode(T.self, from: jsonData)
            return .success(models)
        } catch {
            return .failure(.modelMapFailed(error: error))
        }
    }
}
