//
//  BPNetError.swift
//  BPNetKit
//
//  Created by Mqch on 2021/6/30.
//  Copyright © 2021 com.mqch. All rights reserved.
//

import Foundation
enum BPNetError: Error{
    case notFount
    case authFailed
    case serverInfo(code: Int)
    case detail(code: Int, msg: String)
    case modelMapFailed(error: Error)
    case errorJSON
    case other(error: Error)
}
extension BPNetError: CustomStringConvertible{
    var description: String{
        switch self {
        case .notFount:
            return "URL地址未找到"
        case .authFailed:
            return "TOKEN认证失效"
        case let .serverInfo(code):
            return "服务器错误，错误码：\(code)"
        case let .detail(code, msg):
            return "业务错误，错误码：\(code)，信息：\(msg)"
        case let .modelMapFailed(error):
            return "模型转换失败: \n\(error)"
        case .errorJSON:
            return "返回错误JSON格式"
        case let .other(error):
            return error.localizedDescription
        }
    }
}
