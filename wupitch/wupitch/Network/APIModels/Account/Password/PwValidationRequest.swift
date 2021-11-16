//
//  PwValidationRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/16.
//

import Foundation

// 패스워드 중복인지 아닌지 구분해주는 api
// MARK: - PwValidationData
struct PwValidationData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
