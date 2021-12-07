//
//  GuestInfoData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/07.
//

import Foundation
// MARK: - GuestInfoData
struct GuestInfoData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: GuestInfoResult
}

// MARK: - GuestInfoResult
struct GuestInfoResult: Codable {
    let clubID, guestDue: Int
    let localDates, days: [String]

    enum CodingKeys: String, CodingKey {
        case clubID = "clubId"
        case guestDue, localDates, days
    }
}
