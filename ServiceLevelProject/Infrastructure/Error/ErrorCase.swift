//
//  ErrorCase.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/22.
//

import Foundation
// MARK : 에러 종류 enum
enum LoginError: Int, Error {
    case success = 200
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}

enum SingupError: Int, Error {
    case success = 200
    case regUserError = 201
    case notNickNameError = 202
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}
enum withdrawError: Int, Error {
    case success = 200
    case tokenErorr = 401
    case withdrawUserError = 406
    case serverError = 500
    case clientError = 501
}
enum searchError: Int, Error {
    case success = 200
    case reportUserError = 201
    case cancel1Error = 203
    case cancel2Error = 204
    case cancel3Error = 205
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}
