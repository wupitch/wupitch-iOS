//
//  SignUpUserInfo.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/28.
//

import UIKit
import KakaoSDKUser

// 카카오, 애플
enum LoginMethod {
    case kakao, apple
}

// 회원가입, 메인
enum BottomSheetMethod {
    case signUp, main
}

class SignUpUserInfo {
    static let shared = SignUpUserInfo()
    // 카카오,애플 로직 나누기
    var loginMethod: LoginMethod?
    // 바텀시트 로그인, 메인 나누기
    var bottomSheetMethod: BottomSheetMethod?
    // 지역선택
    var region : Int?
    // 관심 스포츠 선택
    // var sportsList : [Int]
    var etcText : String?
    // 연령대 선택
    var age : Int?
    // 프로필 설정
    var nickName : String?
    var userIntroduce : String?
    // 신분증 사진
    var idImg : UIImage?
    
    func dispose() {
        SignUpUserInfo.shared.region = nil
        SignUpUserInfo.shared.etcText = nil
        SignUpUserInfo.shared.age = nil
        SignUpUserInfo.shared.nickName = nil
        SignUpUserInfo.shared.userIntroduce = nil
        SignUpUserInfo.shared.idImg = nil
    }
    
    private init(){}
}
