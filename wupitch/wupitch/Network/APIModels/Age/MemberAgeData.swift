//
//  MemberAgeData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation

// MARK: - MemberAgeData
struct MemberAgeData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MemberAgeResult
}

// MARK: - MemberAgeResult
struct MemberAgeResult: Codable {
    let ageIdx: Int
    let age: String
}
