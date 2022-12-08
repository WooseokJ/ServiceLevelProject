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
    case mypage
    case queue(lat: Double, long: Double, studylist: [String])
    case search(lat: Double, long: Double)
    case myQueueState
    case searchStop
    case withdraw
    
    case studyPost(otheruid: String)
    case studyAccept(otheruid: String)
    case studyDodge(otheruid: String)
    
    case chatPostSend(chat: String, to: String)
    case chatGetList(lastchatDate: String, from: String)
    case reviewPost(otheruid: String, reputation: [Int], comment: String)
}


extension APIHeader {
    
    var url: URL {
        let baseURL = "http://api.sesac.co.kr:1210/v1/"
        switch self {
        case .signup, .login:
            return URL(string: baseURL+"user")!
        case .mypage:
            return URL(string: baseURL+"user/mypage")!
        case .search:
            return URL(string: baseURL+"queue/search")!
        case .myQueueState:
            return URL(string: baseURL+"queue/myQueueState")!
        case .queue, .searchStop:
            return URL(string: baseURL+"queue")!
        case .withdraw:
            return URL(string: baseURL+"user/withdraw")!
        case .studyPost:
            return URL(string: baseURL+"queue/studyrequest")!
        case .studyAccept:
            return URL(string: baseURL+"queue/studyaccept")!
        case .studyDodge:
            return URL(string: baseURL+"queue/dodge")!
        case .chatPostSend(_, let to):
            return URL(string: baseURL+"chat/\(to)")!
        case .chatGetList(let lastchatDate, let from):
            return URL(string: baseURL+"chat/\(from)?lastchatDate=\(lastchatDate)")!
        case .reviewPost(let otheruid,_ ,_):
            return URL(string: baseURL+"queue/rate/\(otheruid)")!
        }
    }
    var method: HTTPMethod {
        switch self {
        case .mypage: return .put
        case .signup, .queue, .search, .withdraw, .studyPost, .studyAccept, .studyDodge, .chatPostSend, .reviewPost : return .post
        case .login, .myQueueState, .chatGetList : return .get
        case .searchStop: return .delete
        }
    }
    var headers: HTTPHeaders {
        switch self {
        case .mypage, .signup, .search, .queue, .studyPost, .studyAccept, .studyDodge, .chatPostSend, .chatGetList, .reviewPost:
            
            return ["Content-Type" : "application/x-www-form-urlencoded",
                    "idtoken": UserDefaults.standard.string(forKey: "token") ?? ""
            ]
        case .login, .myQueueState, .searchStop, .withdraw:
            return [
                "idtoken": UserDefaults.standard.string(forKey: "token") ?? ""
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
        case .studyPost(let otheruid), .studyAccept(let otheruid), .studyDodge(let otheruid):
            return [
                "otheruid": otheruid
            ]
            
        case .reviewPost(let otheruid , let reputation, let comment):
            return [
                "otheruid": otheruid,
                "reputation": reputation,
                "comment": comment
            ]
        case .chatPostSend(let chat, _):
            return [
                "chat": chat
            ]
        default: return ["":""]
        }
    }
    
}

