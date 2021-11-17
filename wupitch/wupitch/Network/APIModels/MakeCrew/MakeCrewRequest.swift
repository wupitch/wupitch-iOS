//
//  MakeCrewRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/17.
//

import Foundation

struct MakeCrewRequest: Codable {
    var ageList : [Int]
    var areaId : Int
    // 회비
    var conference : Int
    // 요일
    var days : [Int]
    var endTime : Double
    // 추가정보배열
    var extraInfoList : [Int]
    // 손님비
    var guestConference : Int
    var inquiries : String
    var introduction : String
    var location : String
    var sportsId : Int
    var startTime : Double
    // 크루이름
    var title : String
}
