//
//  APISeSac.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/16.
//

import Foundation

enum APISeSac {
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
    static let chatSendURL = baseURL+"chat/"
    static let chatGetListURL = baseURL+"chat/"
    static let reviewPostURL = baseURL+"queue/rate/"

}

enum HeaderSesac{
    static let idtoken = "idtoken"
    static let ContentType = "Content-Type"
    static let ContentTypeValue = "application/x-www-form-urlencoded"
}



enum parameterSesac {
    static let phoneNumber = "phoneNumber"
    static let FCMtoken = "FCMtoken"
    static let nick = "nick"
    static let birth = "birth"
    static let email = "email"
    static let gender = "gender"
    static let lat = "lat"
    static let long = "long"
    static let studylist = "studylist"
    static let otheruid = "otheruid"
    static let reputation = "reputation"
    static let comment = "comment"
    static let chat = "chat"
    static let searchable = "searchable"
    static let ageMin = "ageMin"
    static let ageMax = "ageMax"
    static let study = "study"
}
