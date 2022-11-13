//
//  Enum.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/10.
//

import Foundation

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



struct Login: Codable {
    
    let token: String
}
