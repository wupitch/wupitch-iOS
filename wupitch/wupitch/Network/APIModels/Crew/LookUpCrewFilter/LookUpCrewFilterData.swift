//
//  LookUpCrewFilterData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation
// MARK: - LookUpCrewFilterData
struct LookUpCrewFilterData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: LookUpCrewFilterResult
}

// MARK: - LookUpCrewFilterResult
struct LookUpCrewFilterResult: Codable {
    let crewPickAgeList: [Int]?
    let crewPickAreaID: Int?
    let crewPickAreaName: String?
    let crewPickDays: [Int]?
    let crewPickMemberCountValue: Int?
    let crewPickSportsList: [Int]?

    enum CodingKeys: String, CodingKey {
        case crewPickAgeList
        case crewPickAreaID = "crewPickAreaId"
        case crewPickAreaName, crewPickDays, crewPickMemberCountValue, crewPickSportsList
    }
}
