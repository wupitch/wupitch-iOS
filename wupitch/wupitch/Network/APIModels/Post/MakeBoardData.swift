//
//  MakeBoardData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/15.
//

import Foundation

// 내활동 크루 게시판 글 생성
// MARK: - MakeBoardData
struct MakeBoardData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
}
