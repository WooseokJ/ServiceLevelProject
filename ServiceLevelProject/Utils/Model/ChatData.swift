//
//  ChatContent.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/09.
//

import Foundation
import RealmSwift

class ChatData: Object {
    @Persisted var to: String
    @Persisted var from: String
    @Persisted var chat: String
    @Persisted var createdAt: Date
    
}
