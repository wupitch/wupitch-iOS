//
//  InformationRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import Foundation

// MARK: - InformationRequest
struct InformationRequest: Codable {
    var ageNum : Int
    var areaId : Int
    var introduce : String
    var nickname : String
    var otherSports : String
    var sportsList : [Int]
}
