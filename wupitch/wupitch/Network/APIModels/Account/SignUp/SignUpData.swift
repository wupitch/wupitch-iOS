//
//  SignUpData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/16.
//

import Foundation

// 회원가입 정보 api
// MARK: - SignUpData
struct SignUpData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SignUpResult
}

// MARK: - SignUpResult
struct SignUpResult: Codable {
    let accountID: Int
    let email, nickname, jwt, introduce: String
    let isPushAgree, isChecked: Bool
    let profileImageURL, deviceToken: String?

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case email, nickname, jwt, introduce, isPushAgree, deviceToken, isChecked
        case profileImageURL = "profileImageUrl"
    }
}
