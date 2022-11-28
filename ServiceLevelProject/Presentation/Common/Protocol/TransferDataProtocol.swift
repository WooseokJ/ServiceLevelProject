//
//  TransferDataProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/28.
//

import Foundation


protocol TransferDataProtocol {
    var transferSearchInfo: Search? {get set}
    var apiQueue: APIQueue {get}
}
extension TransferDataProtocol {
    var apiQueue: APIQueue {
        return APIQueue()
    }
}
