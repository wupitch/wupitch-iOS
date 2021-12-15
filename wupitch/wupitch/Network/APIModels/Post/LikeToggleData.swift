//
//  LikeToggleData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/15.
//

import Foundation
// 크루 게시판 좋아요 토글
// MARK: - LikeToggleData
struct LikeToggleData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: LikeToggleResult
}
// MARK: - LikeToggleResult
struct LikeToggleResult: Codable {
    let result: Bool
}

