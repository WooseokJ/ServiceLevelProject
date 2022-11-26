//
//  ErrorCase.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/22.
//

import Foundation

//MARK: Common

enum CommonError: Int, Error {
    case success = 200
    case tokenErorr = 401
    case notUserError = 406
    case serverError = 500
    case clientError = 501
}

// MARK: User


enum SingupError: Int, Error {
    case regUserError = 201
    case notNickNameError = 202
}
enum withdrawError: Int, Error {
    case withdrawUserError = 406
}

//MARK: queue
enum queuePostErorr: Int,Error {
    case reportedThirdUser = 201
    case panaltyOneUser = 203
    case panaltyTwoUeer = 204
    case panaltyThirdUser = 205
}

enum queueStopError: Int, Error {
    case alreadyStopError = 201
}

///// -  스터디함꼐할 새싹검색


enum myQueueStateErorr: Int, Error {
    case notRequest = 201
}

enum studyRequestError: Int,Error {
    case alreadyTomeRequest = 201
    case oppnentStopRequest = 202
}

enum studyAcceptError: Int, Error {
    case opponentToOtherMettingError = 201
    case stopSesacSearchError = 202
    case myToOtherMatchedError = 203
}

enum dodgeError: Int, Error {
    case otherUIDError = 201
}
