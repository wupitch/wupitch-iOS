//
//  ToggleAlarmData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/26.
//

import Foundation

// MARK: - ToggleAlarmData
struct ToggleAlarmData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
