//
//  MakeBoardRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/15.
//

import Foundation

// 내활동 게시글에 보낼 데이터
struct MakeBoardRequest: Codable {
    var contents : String
    var isNotice : Bool
    var noticeTitle : String?
}
