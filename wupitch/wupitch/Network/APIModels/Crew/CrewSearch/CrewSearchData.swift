//
//  CrewSearchData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/05.
//

import Foundation

// MARK: - CrewSearchData
struct CrewSearchData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: CrewSearchResult
}

// MARK: - CrewSearchResult
struct CrewSearchResult: Codable {
    let content: [CrewContent]
    let empty, first, last: Bool
    let number, numberOfElements, size: Int
    let sort: CrewSort
    let totalElements, totalPages: Int
}

// MARK: - Content
struct CrewContent: Codable {
    let areaName: String?
    let clubID: Int
    let clubTitle, crewImage, introduction: String?
    let isPinUp: Bool
    let schedules: [CrewSchedule]
    let sportsID: Int
    let sportsName: String

    enum CodingKeys: String, CodingKey {
        case areaName
        case clubID = "clubId"
        case clubTitle, crewImage, introduction, isPinUp, schedules
        case sportsID = "sportsId"
        case sportsName
    }
}

// MARK: - Schedule
struct CrewSchedule: Codable {
    let day: String
    let dayIdx : Int
    let endTime, startTime: Double?
}

// MARK: - Sort
struct CrewSort: Codable {
    let empty, sorted, unsorted: Bool
}
