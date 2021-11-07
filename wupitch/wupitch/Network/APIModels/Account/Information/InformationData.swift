//
//  InformationData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import Foundation
// 회원정보 한번에 받는 api
// MARK: - InformationData
struct InformationData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
