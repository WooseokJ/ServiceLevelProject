//
//  ChatContent.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/09.
//

import Foundation
import RealmSwift

class ChatData: Object {
    @Persisted(primaryKey: false) var _id = ObjectId()
    @Persisted var to: String
    @Persisted var from: String
    @Persisted var chat: String
    @Persisted var createdAt: String
    
    convenience init(_id: ObjectId = ObjectId(), to: String, from: String, chat: String, createdAt: String) {
        self.init()
        self._id = _id
        self.to = to
        self.from = from
        self.chat = chat
        self.createdAt = createdAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case to, from, chat, createdAt
    }
    
}
