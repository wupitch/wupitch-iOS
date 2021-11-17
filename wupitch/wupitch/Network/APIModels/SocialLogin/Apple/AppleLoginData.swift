//
//  AppleLoginData.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import Foundation

// MARK: - AppleLoginData
struct AppleLoginData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: AppleLoginResult
}

// MARK: - AppleLoginResult
struct AppleLoginResult: Codable {
    let accountID: Int
    let jwt, oauthID: String

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case jwt
        case oauthID = "oauthId"
    }
}
