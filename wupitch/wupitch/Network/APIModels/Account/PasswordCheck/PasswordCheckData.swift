//
//  ChangePasswordData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import Foundation

// 패스워드체크
// MARK: - PasswordCheckData
struct PasswordCheckData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    // 현재 비밀번호와 일치하면 true, 아니면 false
    let result: Bool
}
