//
//  GuestRegisterData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/05.
//

import Foundation
// MARK: - GuestRegisterData
struct GuestRegisterData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
}
