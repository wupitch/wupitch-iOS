//
//  NowRegisterCrewData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/08.
//

import Foundation

// 현재 가입한 크루 조회 API -> 내활동 페이지에 들어감
// MARK: - NowRegisterCrewData
struct NowRegisterCrewData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: [NowRegisterCrewResult]
}

// MARK: - NowRegisterCrewResult
struct NowRegisterCrewResult: Codable {
    let areaName: String?
    let clubID: Int
    let clubTitle, crewImage, introduction: String?
    let isPinUp: Bool?
    let schedules: [NowRegisterCrewSchedule]
    let sportsID: Int
    let sportsName: String
    let isCreate: Bool?

    enum CodingKeys: String, CodingKey {
        case areaName
        case clubID = "clubId"
        case clubTitle, crewImage, introduction, isPinUp, schedules, isCreate
        case sportsID = "sportsId"
        case sportsName
    }
}

// MARK: - NowRegisterCrewSchedule
struct NowRegisterCrewSchedule: Codable {
    let day: String
    let dayIdx: Int
    let endTime, startTime: Double?
}

