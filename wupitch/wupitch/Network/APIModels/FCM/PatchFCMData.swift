//
//  PatchFCMData.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/01.
//

import Foundation
// MARK: - PatchFCMData
struct PatchFCMData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
