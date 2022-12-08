//
//  sesacReportEnum.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/08.
//

import Foundation

enum CVEnum: CaseIterable {
    case review, sesacReport
    var list: [String] {
        switch self {
        case .review:
            return ["좋은 매너","정확한 시간 약속","빠른 응답","친절한 성격","능숙한 실력","유익한 시간"]
        case .sesacReport:
            return ["불법/사기","불편한언행","노쇼","선정성","인신공격","기타"]
        }
    }
}


