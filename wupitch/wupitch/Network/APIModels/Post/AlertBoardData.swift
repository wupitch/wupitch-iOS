//
//  AlertBoardData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/15.
//

import Foundation
// 내활동 크루 게시물 신고
// MARK: - AlertBoardData
struct AlertBoardData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: AlertBoardResult
}

// MARK: - AlertBoardResult
struct AlertBoardResult: Codable {
    let result: Bool
}
