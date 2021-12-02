

import Foundation

// MARK: - CrewDetailData
struct CrewDetailData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: CrewDetailResult
}

// MARK: - CrewDetailResult
struct CrewDetailResult: Codable {
    let ageTable: [String]
    let areaName: String?
    let clubID: Int
    let clubTitle, crewName: String?
    let crewImage: String?
    let dues: Int?
    let extraList: [String]?
    let guestDues: Int?
    let inquiries, introduction: String?
    let isPinUp, isSelect: Bool
    let materials: String?
    let memberCount: Int
    let schedules: [Schedule]?
    let sportsID: Int
    let sportsName: String

    enum CodingKeys: String, CodingKey {
        case ageTable, areaName
        case clubID = "clubId"
        case clubTitle, crewImage, crewName, dues, extraList, guestDues, inquiries, introduction, isPinUp, isSelect, materials, memberCount, schedules
        case sportsID = "sportsId"
        case sportsName
    }
}

// MARK: - Schedule
struct Schedule: Codable {
    let day: String
    let dayIdx: Int
    let endTime, startTime: Double?
}
