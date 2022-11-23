//
//  EndPoint.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//

import Foundation
import Alamofire

enum API {
    case signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String,
                email: String, gender: Int)
    case login(idtoken: String)
    case search(lat: Double, long: Double)
    case myQueueState(idtoken: String)
}

extension API {
    
    var url: URL {
        let baseURL = "http://api.sesac.co.kr:1210/v1/"
        switch self {
        case .signup, .login:
            return URL(string: baseURL+"user")!
        case .search:
            return URL(string: baseURL+"queue/search")!
        case .myQueueState:
            return URL(string: baseURL+"queue/myQueueState")!
        }
        
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login, .search, .myQueueState:
            return ["Content-Type" : "application/x-www-form-urlencoded",
                    "idtoken": UserDefaults.standard.string(forKey: "token")!
            ]
        }
    }
    
//    var path: String {
//           switch self {
//           case .get: return "get"
//           case .post: return "post"
//           }
//       },
    var parameters: [String:Any]? {
        switch self {
        case .signup(let phoneNumber, let FCMtoken, let nick, let birth,
                     let email, let gender):
            return [
                "phoneNumber": phoneNumber,
                "FCMtoken" : FCMtoken,
                "nick" : nick,
                "birth" : birth,
                "email" : email,
                "gender" : gender
            ]
        case .login(let idtoken), .myQueueState(let idtoken):
            return [
                "idtoken" : idtoken
            ]
        case .search(let lat, let long):
            return [
                "lat": Double(lat),
                "long": Double(long)
            ]
            
        default: return nil
        }
    }

    
}
