//
//  SignInData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/17.
//

import Foundation

// 로그인 api
// MARK: - SignInData
struct SignInData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SignInResult?
}

// MARK: - SignInResult
struct SignInResult: Codable {
    let accountID: Int
    let jwt, email: String
    
    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case jwt, email
    }
}
