//
//  ProfileImageData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/22.
//

import Foundation

// 이미지 업로드 api
// MARK: - ProfileImageData
struct ProfileImageData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
