//
//  MakeCrewRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/17.
//

import Foundation

// MARK: - MakeCrewRequest
struct MakeCrewRequest: Codable {
    let ageList: [Int]
    let areaID: Int
    let extraInfoList: [Int]?
    let guestConference, conference: Int?
    let inquiries, introduction: String?
    let location: String?
    let sportsID: Int
    let title: String?
    let memberCount: Int
    let materials: String?
    let scheduleList: [ScheduleList]?

    enum CodingKeys: String, CodingKey {
        case ageList
        case areaID = "areaId"
        case conference, extraInfoList, guestConference, inquiries, introduction, location
        case sportsID = "sportsId"
        case title, memberCount, materials, scheduleList
    }
}

// MARK: - ScheduleList
struct ScheduleList: Codable {
    let dayIdx: Int
    let startTime: Double
    let endTime: Double
}
