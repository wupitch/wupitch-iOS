//
//  GuestRegisterRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/05.
//

import Foundation
// MARK: - GuestRegisterRequest
struct GuestRegisterRequest: Codable {
    let crewID: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case crewID = "crewId"
        case date
    }
}
