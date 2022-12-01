//
//  ChatInfo.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import Foundation

// MARK: - MyQueueState
struct ChatSendInfo: Codable {
    var dodged, matched, reviewed: Int
    var matchedNick, matchedUid: String
}


// MARK: - ChatListInfo
struct ChatListInfo: Codable {
    var payload: [Payload]
}

// MARK: - Payload
struct Payload: Codable {
    var id, to, from, chat: String
    var createdAt: String
}
