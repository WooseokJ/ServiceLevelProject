//
//  ImageEnum.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/27.
//

import Foundation

enum ImageEnum: Int  {
    case sesac1 = 0
    case sesac2
    case sesac3
    case sesac4
    case sesac5
    
    var list: String {
        return "sesac_face_\(rawValue+1).png"
    }
}


