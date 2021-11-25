//
//  WithdrawalData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/25.
//

import Foundation

// 회원탈퇴
// MARK: - WithdrawalData
struct WithdrawalData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
