//
//  LookUpCrewFilterData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation
// MARK: - LookUpCrewFilterData
struct LookUpCrewFilterData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: LookUpCrewFilterResult
}

// MARK: - LookUpCrewFilterResult
struct LookUpCrewFilterResult: Codable {
    let crewPickAreaID: Int?
    let crewPickAgeList, crewPickDays: [Int]?
    let crewPickMemberCountValue: Int?
    let crewPickSportsList: [Int]?
//    let isAsc: Bool?
//    let page: Int
//    let size: Int
//    let sortBy: String

    enum CodingKeys: String, CodingKey {
        case crewPickAreaID = "crewPickAreaId"
        case crewPickAgeList, crewPickDays, crewPickMemberCountValue, crewPickSportsList
    }
}
