//
//  ErrorCase.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/22.
//

import Foundation

// MARK: User
enum loginError: Int, Error {
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}


enum SingupError: Int, Error {
    case regUserError = 201
    case notNickNameError = 202
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}
enum withdrawError: Int, Error {
    case tokenErorr = 401
    case withdrawUserError = 406
    case serverError = 500
    case clientError = 501
}

enum updateFCMToken: Int, Error {
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}
enum myPage: Int, Error {
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}

//MARK: queue
enum queuePostErorr: Int,Error {
    case reportedThirdUser = 201
    case panaltyOneUser = 203
    case panaltyTwoUeer = 204
    case panaltyThirdUser = 205
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}

enum queueStopError: Int, Error {
    case alreadyStopError = 201
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}

///// -  스터디함꼐할 새싹검색
enum searchPostError: Int, Error {
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}

enum myQueueStateErorr: Int, Error {
    case notRequest = 201
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}

enum studyRequestError: Int,Error {
    case alreadyTomeRequest = 201
    case oppnentStopRequest = 202
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}

enum studyAcceptError: Int, Error {
    case opponentToOtherMettingError = 201
    case stopSesacSearchError = 202
    case myToOtherMatchedError = 203
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}

enum dodgeError: Int, Error {
    case otherUIDError = 201
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}
