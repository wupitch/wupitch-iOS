//
//  CrewMemberProfileData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/17.
//

import Foundation

// MARK: - CrewMemberProfileData
struct CrewMemberProfileData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: CrewMemberProfileResult
}

// MARK: - CrewMemberProfileResult
struct CrewMemberProfileResult: Codable {
    let accountID: Int?
    let accountNickname, addedAt: String
    let ageNum: Int
    let area: String
    let clubID: Int
    let guestReserveTime: String?
    let impromptuID: Int?
    let introduction: String
    let isAuthAccountLeader, isGuest, isLeader, isValid: Bool
    let phoneNumber, profileImage: String?
    let sportsList: [Int]

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case accountNickname, addedAt, ageNum, area
        case clubID = "clubId"
        case guestReserveTime
        case impromptuID = "impromptuId"
        case introduction, isAuthAccountLeader, isGuest, isLeader, isValid, phoneNumber, profileImage, sportsList
    }
}

