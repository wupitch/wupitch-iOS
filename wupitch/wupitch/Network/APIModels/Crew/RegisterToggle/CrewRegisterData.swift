//
//  CrewRegisterData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation
// MARK: - CrewRegisterData
struct CrewRegisterData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
