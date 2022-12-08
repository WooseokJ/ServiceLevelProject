//
//  APIQueueProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/08.
//

import Foundation

protocol APIQueueProtocol {
    var apiQueue: APIQueue {get}
}
extension APIQueueProtocol {
    var apiQueue: APIQueue {
        return APIQueue()
    }
}
