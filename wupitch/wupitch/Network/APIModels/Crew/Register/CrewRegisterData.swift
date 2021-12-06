//
//  CrewRegisterData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation

// MARK: - CrewRegisterData
struct CrewRegisterData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: CrewRegisterResult
}

// MARK: - CrewRegisterResult
struct CrewRegisterResult: Codable {
    let result: Bool
}
