//
//  getSportsData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation

// MARK: - MemberSportsData
struct MemberSportsData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MemberSportsResult
}

// MARK: - MemberSportsResult
struct MemberSportsResult: Codable {
    let accountID: Int
    let list: [List]

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case list
    }
}

// MARK: - List
struct List: Codable {
    let sportsID: Int
    let sportsName: String

    enum CodingKeys: String, CodingKey {
        case sportsID = "sportsId"
        case sportsName
    }
}
