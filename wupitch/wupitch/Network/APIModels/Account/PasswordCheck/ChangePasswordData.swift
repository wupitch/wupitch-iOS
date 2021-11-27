//
//  ChangePasswordData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import Foundation

// MARK: - ChangePasswordData
struct ChangePasswordData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
