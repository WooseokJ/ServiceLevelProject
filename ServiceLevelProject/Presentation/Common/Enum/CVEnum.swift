//
//  sesacReportEnum.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/08.
//

import Foundation

enum CVEnum {
    enum review: Int, CaseIterable {
        case good = 0
        case ActualTime = 1
        case fastResponse = 2
        case kindCharacter = 3
        case proficiency = 4
        case usefulTime = 5

        var list: String {
            switch self{
            case .good: return "좋은매너"
            case .ActualTime: return "정확한 시간 약속"
            case .fastResponse: return "빠른 응답"
            case .kindCharacter: return "친절한 성격"
            case .proficiency: return "능숙한 실력"
            case .usefulTime: return "유익한 시간"
            }
        }
    }
    
    enum sesacReport: Int, CaseIterable {
        case illegal = 0
        case uncomfortableWord = 1
        case noShow = 2
        case sensuality = 3
        case personalAttack = 4
        case etc = 5
        var list: String {
            switch self {
            case .illegal: return "불법/사기"
            case .uncomfortableWord: return "불편한언행"
            case .noShow: return "노쇼"
            case .sensuality: return "선정성"
            case .personalAttack: return "인신공격"
            case .etc: return "기타"
            }
        }
    }
    
    

}


