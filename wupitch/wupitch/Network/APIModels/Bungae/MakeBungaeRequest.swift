//
//  MakeBungaeRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import Foundation

// MARK: - MakeBungaeRequest
struct MakeBungaeRequest: Codable {
    let areaID: Int
    let location, materials, title: String?
    let date: String
    let startTime, endTime: Double
    let introduction, inquiries: String
    let recruitmentCount: Int
    let dues: Int?

    enum CodingKeys: String, CodingKey {
        case areaID = "areaId"
        case location, date, startTime, endTime, title, introduction, inquiries, materials, recruitmentCount, dues
    }
}
