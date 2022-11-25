//
//  UserInfo.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/14.
//

import Foundation

class UserInfo {
    static var shared = UserInfo()
    var phoneNumber: String?
    var fcmtoken: String?
    var nick: String?
    var birth: String?
    var email: String?
    var gender: Int?
}

//MARK: - Signup
struct User: Codable {
    let phoneNumber: String
    let FCMtoken: String
    let nick: String
    let birth: String
    let email: String
    let gender: Int
}
