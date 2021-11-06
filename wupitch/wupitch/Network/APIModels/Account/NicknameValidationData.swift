//
//  NicknameValidation.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/06.
//

import Foundation
// 닉네임 중복인지 아닌지 구분해주는 api
// MARK: - NicknameValidationData
struct NicknameValidationData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
