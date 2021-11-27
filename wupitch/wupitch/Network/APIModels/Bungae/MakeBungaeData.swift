//
//  MakeBungaeData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import Foundation

// MARK: - MakeBungaeData
struct MakeBungaeData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MakeBungaeResult
}

// MARK: - MakeBungaeResult
struct MakeBungaeResult: Codable {
    let impromptuID: Int

    enum CodingKeys: String, CodingKey {
        case impromptuID = "impromptuId"
    }
}
