//
//  KakaoLoginData.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/27.
//

import Foundation

// MARK: - KakaoLoginData
struct KakaoLoginData: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: KakaoLoginResult
}

// MARK: - KakaoLoginResult
struct KakaoLoginResult: Decodable {
    let accountID: Int
    let jwt, oauthID: String

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case jwt
        case oauthID = "oauthId"
    }
}

