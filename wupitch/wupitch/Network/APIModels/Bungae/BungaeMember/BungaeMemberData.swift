//
//  BungaeMemberData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/17.
//

import Foundation
// MARK: - BungaeMemberData
struct BungaeMemberData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: [MyActivityBungaeMemberResult]
}

// MARK: - MyActivityBungaeMemberResult
struct MyActivityBungaeMemberResult: Codable {
    let accountID: Int
    let accountNickname, addedAt, profileImage: String?
    let isLeader, isValid: Bool?

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case accountNickname, addedAt, isLeader, isValid, profileImage
    }
}
