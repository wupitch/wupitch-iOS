//
//  FCMData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation

// MARK: - FCMData
struct FCMData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
