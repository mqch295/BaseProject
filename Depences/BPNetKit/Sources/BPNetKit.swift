import Foundation
import Moya
import RxSwift
import RxMoya
public typealias BPNetParamas = [String: Any]
public typealias BPNetHeader = [String : String]
public typealias BPNetJSONResponse = [String: Any]
public enum BFNetAuthType {
    case basic
    case bearer
    case custom(String)
}
public enum BPNetMethod{
    case get(params: BPNetParamas?)
    case post(params: BPNetParamas?)
    var params: BPNetParamas? {
        switch self {
            case .get(params: let params):
                return params
            case .post(params: let params):
                return params
        }
    }
}
extension String{
    func toUrl() -> URL? {
        return URL(string: self)
    }
}

