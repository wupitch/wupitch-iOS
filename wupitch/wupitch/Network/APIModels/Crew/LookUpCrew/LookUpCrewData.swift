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
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: LookUpCrewDataResult
}

// MARK: - LookUpCrewDataResult
struct LookUpCrewDataResult: Codable {
    let content: [LookUpContent]
    let pageable: SetPaging
    let totalPages, totalElements: Int
    let last: Bool
    let size, number: Int
    let sort: ArraySort
    let numberOfElements: Int
    let first, empty: Bool
}

struct LookUpContent: Codable {
    let clubID, sportsID: Int
      let sportsName, clubTitle, introduction: String
      let schedules: [ScheduleArray]
      let crewImage: String?
      let isPinUp: Bool
      let areaName: String?

      enum CodingKeys: String, CodingKey {
          case clubID = "clubId"
          case sportsID = "sportsId"
          case sportsName, clubTitle, introduction, schedules, crewImage, isPinUp, areaName
      }
}

// MARK: - ScheduleArray
struct ScheduleArray: Codable {
    let dayIdx: Int
    let day: String
    let startTime, endTime: Double?
}

// MARK: - SetPaging
struct SetPaging: Codable {
    let sort: ArraySort
    let offset, pageNumber, pageSize: Int
    let paged, unpaged: Bool
}

// MARK: - ArraySort
struct ArraySort: Codable {
    let empty, sorted, unsorted: Bool
}

