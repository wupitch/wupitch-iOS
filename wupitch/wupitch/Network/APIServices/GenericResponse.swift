//
//  GenericResponse.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/29.
//

import Foundation


struct GenericResponse<T: Codable>: Codable {
    var code: Int
    var isSuccess: Bool
    var message: String
    var result: T?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case isSuccess = "isSuccess"
        case message = "message"
        case result = "result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = (try? values.decode(Int.self, forKey: .code)) ?? -1
        isSuccess = (try? values.decode(Bool.self, forKey: .isSuccess)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        print("확인",result)
        result = (try? values.decode(T.self, forKey: .result)) ?? nil
    }
}
