

import Foundation

// MARK: - Welcome
struct CrewDetailData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: CrewDetailResult
}

// MARK: - CrewDetailResult
struct CrewDetailResult: Codable {
    let content: [Content]
    let pageable: Pageable
    let totalPages, totalElements: Int
    let last: Bool
    let size, number: Int
    let sort: Sort
    let numberOfElements: Int
    let first, empty: Bool
}

// MARK: - Content
struct Content: Codable {
    let clubID, sportsID: Int
    let sportsName, clubTitle, introduction: String
    let schedules: [Schedule]
    let crewImage: String?
    let isPinUp: Bool
    let areaName: String

    enum CodingKeys: String, CodingKey {
        case clubID = "clubId"
        case sportsID = "sportsId"
        case sportsName, clubTitle, introduction, schedules, crewImage, isPinUp, areaName
    }
}

// MARK: - Schedule
struct Schedule: Codable {
    let dayIdx: Int
    let day: String
    let startTime, endTime: Int
}

// MARK: - Pageable
struct Pageable: Codable {
    let sort: Sort
    let offset, pageNumber, pageSize: Int
    let paged, unpaged: Bool
}

// MARK: - Sort
struct Sort: Codable {
    let empty, sorted, unsorted: Bool
}
