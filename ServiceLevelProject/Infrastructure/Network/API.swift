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
//    case profile
     
    var url: URL {
        
        let baseURL = "http://api.sesac.co.kr:1207/v1/user"
        
        switch self {
        case .signup:
            return URL(string: baseURL)!
        case .login:
            return URL(string: baseURL)!
//        case .profile:
//            return URL(string: baseURL+"me")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login:
            return ["Content-Type" : "application/x-www-form-urlencoded",
                    "idtoken": UserDefaults.standard.string(forKey: "token")!
            ]
//        case .profile:
//            return [
//                "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "token")!)",
//                "Content-Type" : "application/x-www-form-urlencoded"
//            ]

        }
    }
    
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
        case .login(let idtoken):
            return [
                "idtoken" : idtoken,
            ]
        default: return nil
        }
    }
}


