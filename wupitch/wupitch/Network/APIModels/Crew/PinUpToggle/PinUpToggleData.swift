//
//  PinUpToggleData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation

// MARK: - PinUpToggleData
struct PinUpToggleData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: PinUpToggleResult
}
// MARK: - PinUpToggleResult
struct PinUpToggleResult: Codable {
    let result: Bool
}
