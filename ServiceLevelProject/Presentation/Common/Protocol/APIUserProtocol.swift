//
//  APIUserProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/19.
//

import Foundation

protocol APIUserProtocol {
    var apiUser: APIUser {get}
}

extension APIUserProtocol {
    var apiUser: APIUser {
        return APIUser()
    }
}


