//
//  EndPoint.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//

import Foundation
import Alamofire



enum APIHeader {
    case login
    case signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String,
                email: String, gender: Int)
    case queue(lat: Double, long: Double, studylist: [String])
    case search(lat: Double, long: Double)
    case myQueueState
    case searchStop
    case withdraw
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
        case .queue, .searchStop:
            return URL(string: baseURL+"queue")!
        case .withdraw:
            return URL(string: baseURL+"withdraw")!
        }
    }
    var method: HTTPMethod {
        switch self {
        case .signup, .queue, .search, .withdraw: return .post
        case .login, .myQueueState : return .get
        case .searchStop: return .delete
        }
    }
    var headers: HTTPHeaders {
        switch self {
        case .signup, .search, .queue:
            return ["Content-Type" : "application/x-www-form-urlencoded",
                    "idtoken": UserDefaults.standard.string(forKey: "token")!
            ]
        case .login, .myQueueState, .searchStop, .withdraw:
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

