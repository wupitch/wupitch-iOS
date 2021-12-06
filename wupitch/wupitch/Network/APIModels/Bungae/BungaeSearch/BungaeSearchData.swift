//
//  BungaeSearchData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/07.
//

import Foundation
// MARK: - BungaeSearchData
struct BungaeSearchData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: BungaeSearchResult
}

// MARK: - BungaeSearchResult
struct BungaeSearchResult: Codable {
    let content: [BungaeSearchContent]
    let empty, first, last: Bool
    let number, numberOfElements, size: Int
    let sort: BungaeSearchSort
    let totalElements, totalPages: Int
}

// MARK: - BungaeSearchContent
struct BungaeSearchContent: Codable {
    let date, day: String
    let dday, impromptuID: Int
    let impromptuImage: String?
    let isPinUp: Bool
    let location: String
    let nowMemberCount, recruitmentCount: Int
    let startTime, endTime: Double
    let title: String

    enum CodingKeys: String, CodingKey {
        case date, day, dday, endTime
        case impromptuID = "impromptuId"
        case impromptuImage, isPinUp, location, nowMemberCount, recruitmentCount, startTime, title
    }
}

// MARK: - BungaeSearchSort
struct BungaeSearchSort: Codable {
    let empty, sorted, unsorted: Bool
}
