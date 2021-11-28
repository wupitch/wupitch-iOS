////
////  LookUpCrewData.swift
////  wupitch
////
////  Created by 김수정 on 2021/11/28.
////
//
//import Foundation
//import UIKit
//
//// MARK: - LookUpCrewData
//struct LookUpCrewData: Codable {
//    let isSuccess: Bool
//    let code: Int
//    let message: String
//    let result: LookUpCrewDataResult
//}
//
//// MARK: - LookUpCrewDataResult
//struct LookUpCrewDataResult: Codable {
//    let content: [LookUpCrewContent]
//    let pageable: Pageable
//    let totalPages, totalElements: Int
//    let last: Bool
//    let size, number: Int
//    let sort: Sort
//    let numberOfElements: Int
//    let first, empty: Bool
//}
//
//// MARK: - LookUpCrewContent
//struct LookUpCrewContent: Codable {
//    let clubID, sportsID: Int
//    let sportsName, clubTitle, introduction: String
//    let schedules: [LookUpSchedule]
//    let crewImage: LookUpCrewImageNull?
//    let isPinUp: Bool
//    let areaName: String
//
//    enum CodingKeys: String, CodingKey {
//        case clubID = "clubId"
//        case sportsID = "sportsId"
//        case sportsName, clubTitle, introduction, schedules, crewImage, isPinUp, areaName
//    }
//}
//
//// MARK: - LookUpSchedule
//struct LookUpSchedule: Codable {
//    let dayIdx: Int
//    let day: String
//    let startTime, endTime: Int
//}
//
//// MARK: - Pageable
//struct Pageable: Codable {
//    let sort: Sort
//    let offset, pageNumber, pageSize: Int
//    let paged, unpaged: Bool
//}
//
//// MARK: - Sort
//struct Sort: Codable {
//    let empty, sorted, unsorted: Bool
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//    }
//}
