//
//  BFNetReachability.swift
//  BPNetKit
//
//  Created by Mqch on 2021/6/30.
//  Copyright © 2021 com.mqch. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
public class BFNetReachability{
    public static let shared = BFNetReachability()
    private let manager: NetworkReachabilityManager?
    public enum BFNetReachabilityStatus{
        case unknown
        case notReachable
        case wwan
        case wifi
    }
    private var currentStatus: BFNetReachabilityStatus = .unknown{
        didSet{
            reachability.onNext(currentStatus)
        }
    }
    private init() {
        manager = NetworkReachabilityManager(host: "https://www.baidu.com")
        manager?.startListening(onUpdatePerforming: { [weak self] status in
            switch status {
            case .unknown:
                self?.currentStatus = .unknown
            case .notReachable:
                self?.currentStatus = .notReachable
            case .reachable(.cellular):
                self?.currentStatus = .wwan
            case .reachable(.ethernetOrWiFi):
                self?.currentStatus = .wifi
            }
        })
        
    }
    public var isReachable: Bool {
        manager?.isReachable ?? false
    }
    public var status: BFNetReachabilityStatus{
        return currentStatus
    }
    public var reachability: PublishSubject<BFNetReachabilityStatus> = .init()
}
