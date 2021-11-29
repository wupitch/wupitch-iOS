//
//  LookUpCrewRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/29.
//

import Foundation
import Alamofire

struct LookUpCrewRequest {
    var ageList: [Int]?
    var areaId: Int?
    var days: [Int]?
    var isAsc: Bool?
    var memberCountValue: Int?
    var page: Int?
    var size: Int?
    var sortBy: String?
    var sportsList: [Int]?
}
