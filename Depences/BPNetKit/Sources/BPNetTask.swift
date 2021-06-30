//
//  BPNetTask.swift
//  BPNetKit
//
//  Created by Mqch on 2021/6/30.
//  Copyright © 2021 com.mqch. All rights reserved.
//

import Foundation
import Moya
struct BPNetTask: TargetType, AccessTokenAuthorizable{
    var authorizationType: AuthorizationType?
    
    var baseURL: URL
    
    var path: String
    
    var method: Moya.Method
    
    var sampleData: Data
    
    var task: Moya.Task
    
    var headers: [String : String]?
    
    init(baseUrl: String, path: String, headers: BPNetHeader, method: BPNetMethod){
        assert(baseUrl.toUrl() != nil, "URL不合法")
        self.baseURL = baseUrl.toUrl()!
        self.path = path
        self.sampleData = Data()
        self.headers = headers
        switch method {
            case .get:
                self.method = .get
            case .post:
                self.method = .post
        }
        if let params = method.params{
            self.task = .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }else{
            self.task = .requestPlain
        }
    }
    
}
