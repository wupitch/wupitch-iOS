//
//  MemberAreaData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation

// MARK: - MemberAreaData
struct MemberAreaData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MemberAreaResult
}

// MARK: - MemberAreaResult
struct MemberAreaResult: Codable {
    let areaID: Int
    let areaName: String

    enum CodingKeys: String, CodingKey {
        case areaID = "areaId"
        case areaName
    }
}
