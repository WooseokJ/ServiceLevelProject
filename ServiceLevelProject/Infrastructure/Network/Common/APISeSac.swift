//
//  APISeSac.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/16.
//

import Foundation

enum APISeSac {
    
    case to
    case from
    case lastchatDate
    case otheruid
    
    static let baseURL = "http://api.sesac.co.kr:1210/v1/"
    static let userURL = baseURL+"user"
    static let mypageURL = baseURL+"user/mypage"
    static let searchURL = baseURL+"queue/search"
    static let myQueueStateURL = baseURL + "queue/myQueueState"
    static let queueURL = baseURL + "queue"
    static let withdrawURL = baseURL + "user/withdraw"
    static let studyPostURL = baseURL + "queue/studyrequest"
    static let studyAccept = baseURL + "queue/studyaccept"
    static let studyDodge = baseURL + "queue/dodge"
    static let chatSendURL = baseURL+"chat/\(to)"
    static let chatGetListURL = baseURL+"chat/\(from)?lastchatDate=\(lastchatDate)"
    
}

enum HeaderSesac {
    static let idtoken = "idtoken"
    static let ContentType = "Content-Type"
    static let ContentTypeValue = "application/x-www-form-urlencoded"
}




