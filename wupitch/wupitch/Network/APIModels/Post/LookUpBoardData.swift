//
//  LookUpBoardData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/15.
//

import Foundation
// 크루 게시판 조회
// MARK: - LookUpBoardData
struct LookUpBoardData: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: [LookUpBoardResult]
}

// MARK: - LookUpBoardResult
struct LookUpBoardResult: Codable {
    let accountProfileImage, contents, date: String?
    let isAccountLike, isAccountReport, isCreator, isCreatorCrewLeader: Bool
    let isNotice, isPhotoPost: Bool
    let likeCount: Int
    let nickname, noticeTitle: String?
    let postID: Int

    enum CodingKeys: String, CodingKey {
        case accountProfileImage, contents, date, isAccountLike, isAccountReport, isCreator, isCreatorCrewLeader, isNotice, isPhotoPost, likeCount, nickname, noticeTitle
        case postID = "postId"
    }
}

