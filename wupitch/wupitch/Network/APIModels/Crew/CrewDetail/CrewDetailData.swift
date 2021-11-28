//
//  CrewDetailData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation

// MARK: - CrewDetailData
struct CrewDetailData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: CrewDetailResult
}

// MARK: - CrewDetailResult
struct CrewDetailResult: Codable {
    let clubID, sportsID: Int
    let sportsName, areaName, clubTitle, crewName: String
    let dues, guestDues, memberCount: Int
    let extraList, ageTable: [String]
    let introduction: String
    let schedules: [Schedule]
    let crewImage: JSONNull?

    enum CodingKeys: String, CodingKey {
        case clubID = "clubId"
        case sportsID = "sportsId"
        case sportsName, areaName, clubTitle, crewName, dues, guestDues, memberCount, extraList, ageTable, introduction, schedules, crewImage
    }
}

// MARK: - Schedule
struct Schedule: Codable {
    let dayIdx: Int
    let day: String
    let startTime, endTime: Double
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
