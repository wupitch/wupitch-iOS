//
//  KakaoLoginRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/30.
//

import Foundation

struct KakaoLoginRequest: Codable {
    var email: String
    var genderType: String
    var id: Int64
    var nickname: String
}
