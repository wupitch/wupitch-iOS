//
//  SignUpRequest.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/16.
//

import Foundation

struct SignUpRequest: Codable {
    var email : String
    var introduce : String
    var isPushAgree : Bool
    var nickname : String
    var password : String
}
