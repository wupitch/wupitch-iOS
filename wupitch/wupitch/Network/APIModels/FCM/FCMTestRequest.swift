//
//  FCMTestRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/06.
//

import Foundation
// MARK: - FCMTestRequest
struct FCMTestRequest: Codable {
    var contents : String
    var targetToken : String
    var title : String
}
