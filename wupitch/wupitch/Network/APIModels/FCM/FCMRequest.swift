//
//  FCMRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation

// MARK: - FCMRequest
struct FCMRequest: Codable {
    let contents, targetToken, title: String
}
