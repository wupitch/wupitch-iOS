//
//  PhoneNumberData.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation

// MARK: - MemberPhoneNumberData
struct MemberPhoneNumberData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MemberPhoneNumberResult
}

// MARK: - MemberPhoneNumberResult
struct MemberPhoneNumberResult: Codable {
    let phoneNumber: String
}
