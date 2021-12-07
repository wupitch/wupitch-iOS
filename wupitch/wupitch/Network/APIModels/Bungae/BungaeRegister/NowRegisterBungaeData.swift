//
//  NowRegisterBungaeData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/08.
//

import Foundation

// 현재 가입한 번개 조회 API -> 내활동 페이지에 들어감
// MARK: - NowRegisterBungaeData
struct NowRegisterBungaeData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: [NowRegisterBungaeResult]
}

// MARK: - NowRegisterBungaeResult
struct NowRegisterBungaeResult: Codable {
    let date, day: String
    let dday, impromptuID: Int
    let impromptuImage: String
    let isPinUp: Bool
    let location: String
    let nowMemberCount, recruitmentCount: Int
    let endTime, startTime: Double?
    let title: String

    enum CodingKeys: String, CodingKey {
        case date, day, dday, endTime
        case impromptuID = "impromptuId"
        case impromptuImage, isPinUp, location, nowMemberCount, recruitmentCount, startTime, title
    }
}
