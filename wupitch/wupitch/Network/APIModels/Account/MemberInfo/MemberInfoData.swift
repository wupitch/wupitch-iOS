//
//  MemberInfoData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import Foundation

// MARK: - MemberInfoData
struct MemberInfoData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MemberInfoResult
}

// MARK: - MemberInfoResult
struct MemberInfoResult: Codable {
    let accountID: Int
    let email, nickname, jwt, introduce: String
    let isChecked, isPushAgree: Bool
    let profileImageURL, deviceToken: String?

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case email, nickname, jwt, introduce, isPushAgree, isChecked
        case profileImageURL = "profileImageUrl"
        case deviceToken
    }
}
