//
//  ExtraData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/22.
//

import Foundation
// MARK: - ExtraData
struct ExtraData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [ExtraResult]
}

// MARK: - ExtraResult
struct ExtraResult: Codable {
    let extraID: Int
    let info: String

    enum CodingKeys: String, CodingKey {
        case extraID = "extraId"
        case info
    }
}
