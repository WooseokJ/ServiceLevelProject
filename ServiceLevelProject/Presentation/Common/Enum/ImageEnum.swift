//
//  ImageEnum.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/27.
//

import Foundation

enum ImageEnum: Int, CaseIterable  {
    case sesac1 = 0
    case sesac2 = 1
    case sesac3 = 2
    case sesac4 = 3
    case sesac5 = 4
    
    var list: String {
        return "sesac_face_\(rawValue)+1).png"
    }
}


