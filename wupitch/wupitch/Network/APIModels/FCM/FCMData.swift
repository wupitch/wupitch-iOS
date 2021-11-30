//
//  FCMData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation

// MARK: - FCMData
struct FCMData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: [FCMResult]
}

// MARK: - FCMResult
struct FCMResult: Codable {
    let accountID: Int
    let contents: String
    let fcmID: Int
    let isChecked: Bool
    let title: String

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case contents
        case fcmID = "fcmId"
        case isChecked, title
    }
}
