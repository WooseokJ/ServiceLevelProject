//
//  Enum.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/10.
//

import UIKit

enum login: String {
    case textLabel = "새싹 서비스 이용을 위해 \n휴대폰 번호를 입력해 주세요."
    case textFieldPlaceholder = "휴대폰 번호(-없이 숫자만 입력)"
    case textButton = "인증 문자 받기"
}


enum AuthText: String {
    case textLabel = "인증번호가 문자로 전송되었어요"
    case textFieldPlaceholder = "인증번호 입력"
    case textButton = "인증 문자 받기"
    case textReDirectButton = "재전송"
}

enum birthDay: String, CaseIterable {
    case year,month,day
    var list: [String] {
        switch self {
        case .year:
            return [Int](1970...Date().year).map{String($0)}
        case .month:
            return [Int](1...12).map{String($0)}
        case .day:
            return [Int](1...31).map{String($0)}
        }
    }
}

enum MyInfo: CaseIterable {
    case content
    var list: [String] {
        switch self {
        case .content:
            return ["김새싹","공지사항","자주 묻는 질문","1:1문의","알림 설정","이용약관"]
        }
    }
    
}
enum InfoManageMent: CaseIterable {
    case content, title, sesacStudy
    var list: [String] {
        switch self {
        case .content:
            return ["내 성별","자주 하는 스터디","내 번호 검색 허용","상대방 연령대","회원탈퇴"]
        case .title:
            return ["좋은 매너", "정확한 시간 약속", "빠른 응답", "친절한 성격","능숙한 실력","유익한 시간"]
        case .sesacStudy:
            return ["부동산투자","주식","Swift"]
        }
    
    }
}




struct Login: Codable {
    
    let idtoken: String
}


