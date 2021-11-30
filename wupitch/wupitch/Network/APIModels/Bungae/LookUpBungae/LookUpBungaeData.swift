//
//  LookUpBungaeData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation

// MARK: - LookUpBungaeData
struct LookUpBungaeData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: LookUpBungaeResult
}

// MARK: - LookUpBungaeResult
struct LookUpBungaeResult: Codable {
    let content: [LookUpBungaeContent]
    let empty, first, last: Bool
    let number, numberOfElements, size: Int
    let sort: BungaeSort
    let totalElements, totalPages: Int
}

// MARK: - Content
struct LookUpBungaeContent: Codable {
    let date, day: String
    let dday, impromptuID: Int
    let impromptuImage: String?
    let isPinUp: Bool
    let location: String?
    let nowMemberCount, recruitmentCount: Int
    let startTime, endTime: Double
    let title: String

    enum CodingKeys: String, CodingKey {
        case date, day, dday, endTime
        case impromptuID = "impromptuId"
        case impromptuImage, isPinUp, location, nowMemberCount, recruitmentCount, startTime, title
    }
}

// MARK: - Sort
struct BungaeSort: Codable {
    let empty, sorted, unsorted: Bool
}

