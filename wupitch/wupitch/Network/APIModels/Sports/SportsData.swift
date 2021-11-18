//
//  SportsData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/19.
//

import Foundation

// MARK: - SportsData
struct SportsData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [SportsResult]
}

// MARK: - SportsResult
struct SportsResult: Codable {
    let sportsID: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case sportsID = "sportsId"
        case name
    }
}
