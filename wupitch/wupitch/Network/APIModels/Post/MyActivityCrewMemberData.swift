//
//  MyActivityCrewMemberData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/16.
//

import Foundation

// MARK: - MyActivityCrewMemberData
struct MyActivityCrewMemberData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: [MyActivityCrewMemberResult]
}

// MARK: - MyActivityCrewMemberResult
struct MyActivityCrewMemberResult: Codable {
    let accountID: Int
    let accountNickname, addedAt, guestReserveTime, profileImage : String?
    let isGuest, isLeader, isValid: Bool?

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case accountNickname, addedAt, guestReserveTime, isGuest, isLeader, isValid, profileImage
    }
}
