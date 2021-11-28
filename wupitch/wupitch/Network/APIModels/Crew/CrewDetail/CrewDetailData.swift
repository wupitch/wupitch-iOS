

import Foundation

// MARK: - Welcome
struct AA: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
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
    let crewImage: JSONNull?
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

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

