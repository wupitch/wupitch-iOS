//
//  EmailValidationData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/16.
//

import Foundation

// 이메일 중복인지 아닌지 구분해주는 api
// MARK: - EmailValidationData
struct EmailValidationData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
