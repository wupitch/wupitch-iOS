//
//  BungaeRegisterData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/01.
//

import Foundation

// MARK: - BungaeRegisterData
struct BungaeRegisterData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: BungaeRegisterResult
}

// MARK: - BungaeRegisterResult
struct BungaeRegisterResult: Codable {
    let result: Bool
}
