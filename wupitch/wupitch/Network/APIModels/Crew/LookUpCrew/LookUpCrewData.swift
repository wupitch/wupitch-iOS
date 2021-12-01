//
//  LookUpCrewData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation
import UIKit

// MARK: - LookUpCrewData
struct LookUpCrewData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: LookUpCrewDataResult
}

// MARK: - LookUpCrewDataResult
struct LookUpCrewDataResult: Codable {
    let content: [LookUpCrewContent]
    let empty, first, last: Bool
    let number, numberOfElements, size: Int
    let sort: Sort
    let totalElements, totalPages: Int
}

// MARK: - LookUpCrewContent
struct LookUpCrewContent: Codable {
    let areaName: String?
    let clubID: Int
    let clubTitle, introduction: String
    let crewImage: String?
    let isPinUp: Bool
    let schedules: [LookUpCrewSchedule]
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
struct LookUpCrewSchedule: Codable {
    let day: String
    let dayIdx: Int
    let endTime, startTime: Double?
}

// MARK: - Sort
struct Sort: Codable {
    let empty, sorted, unsorted: Bool
}
