//
//  UserInfo.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/14.
//

import Foundation

//class UserInfo {
//    static var shared = UserInfo()
//    var phoneNumber: String?
//    var fcmtoken: String?
//    var nick: String?
//    var birth: String?
//    var email: String?
//    var gender: Int?
//}

// MARK: - UserInfo
class LoginInfo: Codable {

    var id: String?
    var v: Int?
    var uid, phoneNumber, email, fcMtoken: String?
    var nick, birth: String?
    var gender: Int?
    var study: String?
    var comment: [String]?
    var reputation: [Int]?
    var sesac: Int?
    var sesacCollection: [Int]?
    var background: Int?
    var backgroundCollection: [Int]?
    var purchaseToken, transactionID, reviewedBefore: [String]?
    var reportedNum: Int?
    var reportedUser: [String]?
    var dodgepenalty, dodgeNum, ageMin, ageMax: Int?
    var searchable: Int?
    var createdAt: String?
    
    init(id: String, v: Int, uid: String, phoneNumber: String, email: String, fcMtoken: String, nick: String, birth: String, gender: Int, study: String, comment: [String], reputation: [Int], sesac: Int, sesacCollection: [Int], background: Int, backgroundCollection: [Int], purchaseToken: [String], transactionID: [String], reviewedBefore: [String], reportedNum: Int, reportedUser: [String], dodgepenalty: Int, dodgeNum: Int, ageMin: Int, ageMax: Int, searchable: Int, createdAt: String) {
        self.id = id
        self.v = v
        self.uid = uid
        self.phoneNumber = phoneNumber
        self.email = email
        self.fcMtoken = fcMtoken
        self.nick = nick
        self.birth = birth
        self.gender = gender
        self.study = study
        self.comment = comment
        self.reputation = reputation
        self.sesac = sesac
        self.sesacCollection = sesacCollection
        self.background = background
        self.backgroundCollection = backgroundCollection
        self.purchaseToken = purchaseToken
        self.transactionID = transactionID
        self.reviewedBefore = reviewedBefore
        self.reportedNum = reportedNum
        self.reportedUser = reportedUser
        self.dodgepenalty = dodgepenalty
        self.dodgeNum = dodgeNum
        self.ageMin = ageMin
        self.ageMax = ageMax
        self.searchable = searchable
        self.createdAt = createdAt
    }
}

struct signupInfo: Codable {
    var phoneNumber, fcMtoken, nick, birth: String
    var email: String
    var gender: Int
}

struct MypageInfo: Codable {
    var searchable, ageMin, ageMax, gender: Int
    var study: String
}
