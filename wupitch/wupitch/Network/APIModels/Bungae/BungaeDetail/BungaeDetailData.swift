//
//  BungaeDetailData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation

// MARK: - BungaeDetailData
struct BungaeDetailData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: BungaeDetailResult
}

// MARK: - BungaeDetailResult
struct BungaeDetailResult: Codable {
    let date, day: String
    let dday, dues, impromptuID: Int
    let impromptuImage, inquiries, introduction: String?
    let isPinUp, isSelect: Bool
    let location, materials: String?
    let nowMemberCount, recruitmentCount: Int
    let title: String
    let endTime, startTime: Double?

    enum CodingKeys: String, CodingKey {
        case date, day, dday, dues, endTime
        case impromptuID = "impromptuId"
        case impromptuImage, inquiries, introduction, isPinUp, isSelect, location, materials, nowMemberCount, recruitmentCount, startTime, title
    }
}
