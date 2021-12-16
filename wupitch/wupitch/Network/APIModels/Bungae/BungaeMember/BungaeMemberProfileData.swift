//
//  BungaeMemberProfileData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/17.
//

import Foundation

// 번개 멤버 프로필 조회
// MARK: - BungaeMemberProfileData
struct BungaeMemberProfileData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: BungaeMemberProfileResult
}

// MARK: - BungaeMemberProfileResult
struct BungaeMemberProfileResult: Codable {
    let accountID: Int
    let accountNickname, addedAt: String
    let ageNum: Int
    let area: String
    let clubID: Int?
    let guestReserveTime: String?
    let impromptuID: Int
    let introduction: String
    let isGuest, isLeader, isValid, isAuthAccountLeader: Bool?
    let phoneNumber, profileImage: String?
    let sportsList: [Int]

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case accountNickname, addedAt, ageNum, area
        case clubID = "clubId"
        case guestReserveTime
        case impromptuID = "impromptuId"
        case introduction, isGuest, isLeader, isValid, phoneNumber, profileImage, sportsList, isAuthAccountLeader
    }
}
