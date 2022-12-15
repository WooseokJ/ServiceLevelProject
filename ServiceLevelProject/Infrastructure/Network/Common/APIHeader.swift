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
        switch self {
            case .signup, .login: return URL(string: APISeSac.userURL)!
            case .mypage: return URL(string: APISeSac.mypageURL)!
            case .search: return URL(string: APISeSac.searchURL)!
            case .myQueueState: return URL(string: APISeSac.myQueueStateURL)!
            case .queue, .searchStop: return URL(string: APISeSac.queueURL)!
            case .withdraw: return URL(string: APISeSac.withdrawURL)!
            case .studyPost: return URL(string: APISeSac.studyPostURL)!
            case .studyAccept: return URL(string: APISeSac.studyAccept)!
            case .studyDodge: return URL(string: APISeSac.studyDodge)!
            
            case .chatPostSend(_,let to): return URL(string: APISeSac.chatSendURL + to)!
            case .chatGetList(let lastchatDate, let from): return URL(string: APISeSac.chatGetListURL + from + "?lastchatDate=" + lastchatDate)!
            case .reviewPost(let otheruid,_,_): return URL(string: APISeSac.reviewPostURL + otheruid)!
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
            
            return [ HeaderSesac.ContentType: HeaderSesac.ContentTypeValue,
                     HeaderSesac.idtoken: UserDefaults.standard.string(forKey: "token") ?? ""
            ]
        case .login, .myQueueState, .searchStop, .withdraw:
            return [
                HeaderSesac.idtoken: UserDefaults.standard.string(forKey: "token") ?? ""
            ]
    
        }
    }
    var parameters: Parameters {
        switch self {
        case .signup(let phoneNumber, let FCMtoken, let nick, let birth,
                     let email, let gender):
            return [
                parameterSesac.phoneNumber: phoneNumber,
                parameterSesac.FCMtoken : FCMtoken,
                parameterSesac.nick : nick,
                parameterSesac.birth : birth,
                parameterSesac.email : email,
                parameterSesac.gender : gender
            ]
        case .search(let lat, let long):
            return [
                parameterSesac.lat: lat,
                parameterSesac.long: long
            ]
        case .queue(let lat, let lng, let studylist):
            return [
                parameterSesac.lat: lat,
                parameterSesac.long: lng,
                parameterSesac.studylist: studylist
            ]
        case .studyPost(let otheruid), .studyAccept(let otheruid), .studyDodge(let otheruid):
            return [
                parameterSesac.otheruid: otheruid
            ]
            
        case .reviewPost(let otheruid , let reputation, let comment):
            return [
                parameterSesac.otheruid: otheruid,
                parameterSesac.reputation: reputation,
                parameterSesac.comment: comment
            ]
        case .chatPostSend(let chat, _):
            return [
                parameterSesac.chat: chat
            ]
        default: return ["":""]
        }
    }
    
}

