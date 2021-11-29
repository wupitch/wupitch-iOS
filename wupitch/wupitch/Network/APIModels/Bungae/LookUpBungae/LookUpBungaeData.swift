//
//  LookUpBungaeData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation

// MARK: - LookUpBungaeData
struct LookUpBungaeData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: LookUpBungaeResult
}

// MARK: - LookUpBungaeResult
struct LookUpBungaeResult: Codable {
    let content: [LookUpBungaeContent]
    let pageable: BungaePagaing
    let last: Bool
    let totalPages, totalElements, size, number: Int
    let sort: BungaeSort
    let first: Bool
    let numberOfElements: Int
    let empty: Bool
}

// MARK: - LookUpBungaeContent
struct LookUpBungaeContent: Codable {
    let impromptuID: Int
    let impromptuImage: String?
    let title, date, day, location: String
    let nowMemberCount, recruitmentCount: Int
    let startTime, endTime: Double
    let isPinUp: Bool
    let dday: Int

    enum CodingKeys: String, CodingKey {
        case impromptuID = "impromptuId"
        case impromptuImage, title, date, day, location, nowMemberCount, recruitmentCount, startTime, endTime, isPinUp, dday
    }
}

// MARK: - BungaePagaing
struct BungaePagaing: Codable {
    let sort: BungaeSort
    let offset, pageNumber, pageSize: Int
    let paged, unpaged: Bool
}

// MARK: - BungaeSort
struct BungaeSort: Codable {
    let empty, sorted, unsorted: Bool
}
