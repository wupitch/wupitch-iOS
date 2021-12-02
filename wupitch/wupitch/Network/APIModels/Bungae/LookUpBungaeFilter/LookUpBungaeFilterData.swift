//
//  LookUpBungaeFilter.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/02.
//

import Foundation
// MARK: - LookUpBungaeFilterData
struct LookUpBungaeFilterData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: LookUpBungaeFilterResult
}

// MARK: - LookUpBungaeFilterResult
struct LookUpBungaeFilterResult: Codable {
    let impromptuPickAreaID: Int?
    let impromptuPickAreaName: String?
    let impromptuPickDays: [Int]?
    let impromptuPickMemberCountValue, impromptuPickScheduleIndex: Int?

    enum CodingKeys: String, CodingKey {
        case impromptuPickAreaID = "impromptuPickAreaId"
        case impromptuPickAreaName, impromptuPickDays, impromptuPickMemberCountValue, impromptuPickScheduleIndex
    }
}
