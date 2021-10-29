//
//  SignUpUserInfo.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/28.
//

import UIKit
import KakaoSDKUser

enum LoginMethod {
    case kakao, apple
}

class SignUpUserInfo {
    
    static let shared = SignUpUserInfo()
    var loginMethod: LoginMethod?
    // 카카오 로그인
    var kakaoUser : Gender?
    // 애플 로그인
    var appleUser : String?
    // 약관동의
    var termsArray = Array<TermsArray>()
    // 지역선택
    var region : String?
    // 관심 스포츠 선택
    var sportsArray = Array<SportsArray>()
    // 연령대 선택
    var age : Bool?
    // 프로필 설정
    var nickName : String?
    var userIntroduce : String?
    // 신분증 사진
    var idImg : UIImage?
    
    private init(){}
}

struct TermsArray {
    var allAgree : Bool
    var termsOfUse : Bool
    var privacyInfo : Bool
    var pushAlert : Bool
}

struct SportsArray {
    // 스포츠 버튼
    var soccer : Bool
    var badminton : Bool
    var volleyball : Bool
    var basketball : Bool
    var mountain : Bool
    var running : Bool
    var etc : Bool
    
    // 실력 버튼
    var soccerHigh : Bool
    var soccerMiddle : Bool
    var soccerLow : Bool
    
    var badmintonHigh : Bool
    var badmintonMiddle : Bool
    var badmintonLow : Bool
    
    var volleyballHigh : Bool
    var volleyballMiddle : Bool
    var volleyballLow : Bool
    
    var basketballHigh : Bool
    var basketballMiddle : Bool
    var basketballLow : Bool
    
    var mountainHigh : Bool
    var mountainMiddle : Bool
    var mountainLow : Bool
    
    var runningHigh : Bool
    var runningMiddle : Bool
    var runningLow : Bool
    
    var etcText : String
}
