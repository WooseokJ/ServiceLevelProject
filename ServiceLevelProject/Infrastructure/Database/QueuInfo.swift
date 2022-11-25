//
//  queuInfo.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/26.
//

import Foundation


// MARK: - Search
struct Search: Codable {
    var fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    var fromRecommend: [String]
}

// MARK: - FromQueueDB
struct FromQueueDB: Codable {
    var uid, nick: String
    var lat, long: Double
    var reputation: [Int]
    var studylist, reviews: [String]
    var gender, type, sesac, background: Int
}

// MARK: - MyQueueState
struct MyQueueState {
    var dodged, matched, reviewed: Int
    var matchedNick, matchedUid: String
}
