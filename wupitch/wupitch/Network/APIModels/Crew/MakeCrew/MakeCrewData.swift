//
//  MakeCrewData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/17.
//

import Foundation

// 크루 생성 api
// MARK: - MakeCrewData
struct MakeCrewData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MakeCrewResult
}

// MARK: - MakeCrewResult
struct MakeCrewResult: Codable {
    let clubID: Int

    enum CodingKeys: String, CodingKey {
        case clubID = "clubId"
    }
}
