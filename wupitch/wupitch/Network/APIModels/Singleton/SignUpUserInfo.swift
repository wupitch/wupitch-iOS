//
//  SignUpUserInfo.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/28.
//

import UIKit
import KakaoSDKUser

// 회원가입, 메인
enum BottomSheetMethod {
    case signUp, main
}

class SignUpUserInfo {
    static let shared = SignUpUserInfo()
    // 바텀시트 로그인, 메인 나누기
    var bottomSheetMethod: BottomSheetMethod?
    
    // -------------------
    // 회원가입에 넣을 값
    var isPushAgree : Bool?
    var email : String?
    var password : String?
    var nickname : String?
    var introduce : String?
    
    // 스포츠 조회에 넣을 싱글톤 -> id값
    var sports : [Int] = [1,2,3,4,5,6,7]
    
    // 스포츠 버튼 눌렸을 때 전달할 값
    var clickSportsBtn : Int?
    // ------------------------
    
    // 지역선택
    var region : Int?
    // 관심 스포츠 선택
    // var sportsList : [Int]
    var etcText : String?
    // 연령대 선택
    var age : Int?
    // 프로필 설정
    //var nickName : String?
    //var userIntroduce : String?
    // 신분증 사진
    var idImg : UIImage?
    
    // 크루만들기 기본 정보
    var crewName : String?
    var crewCount : String?
    var ageBtn : Int?
    var addInfo : Int?
    
    // 크루만들기 포토부분
    var photo : UIImage?
    var title : String?
    var crewInfo : String?
    var materials : String?
    var question : String?
    
    func dispose() {
        SignUpUserInfo.shared.region = nil
        SignUpUserInfo.shared.etcText = nil
        SignUpUserInfo.shared.age = nil
        //SignUpUserInfo.shared.nickName = nil
        //SignUpUserInfo.shared.userIntroduce = nil
        SignUpUserInfo.shared.idImg = nil
    }
    
    private init(){}
}
