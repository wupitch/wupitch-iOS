//
//  BungaePinUpToggleData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/01.
//

import Foundation

// MARK: - BungaePinUpToggleData
struct BungaePinUpToggleData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: BungaePinUpToggleResult
}
// MARK: - BungaePinUpToggleResult
struct BungaePinUpToggleResult: Codable {
    let result: Bool
}
