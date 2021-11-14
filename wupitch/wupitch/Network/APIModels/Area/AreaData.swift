//
//  AreaData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/14.
//

import Foundation
// 지역 조회 API
// MARK: - AreaData
struct AreaData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [AreaResult]
}

// MARK: - AreaResult
struct AreaResult: Codable {
    let areaID: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case areaID = "areaId"
        case name
    }
}
