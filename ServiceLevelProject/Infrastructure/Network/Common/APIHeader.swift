//
//  EndPoint.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//

import Foundation
import Alamofire



enum APIHeader {
    case login(idtoken: String)
    case signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String,
                email: String, gender: Int)
    case queue(lat: Double, long: Double, studylist: [String])
    case search(lat: Double, long: Double)
    case myQueueState(idtoken: String)
    
}


extension APIHeader {
    
    var url: URL {
        let baseURL = "http://api.sesac.co.kr:1210/v1/"
        switch self {
        case .signup, .login:
            return URL(string: baseURL+"user")!
        case .search:
            return URL(string: baseURL+"queue/search")!
        case .myQueueState:
            return URL(string: baseURL+"queue/myQueueState")!
        case .queue:
            return URL(string: baseURL+"queue")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signup:
            return .post
        case .login:
            return .get
        case .queue:
            return .post
        case .search:
            return .post
        case .myQueueState:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .search, .queue:
            return ["Content-Type" : "application/x-www-form-urlencoded",
                    "idtoken": UserDefaults.standard.string(forKey: "token")!
            ]
        case .login, .myQueueState:
            return [
                "idtoken": UserDefaults.standard.string(forKey: "token")!
            ]
        }
    }

    var parameters: Parameters {
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
                "lat": lat,
                "long": long
            ]
        case .queue(let lat, let lng, let studylist):
            return [
                "lat": lat,
                "long": lng,
                "studylist": studylist
            ]
        default: return ["":""]
        }
    }
    
}

