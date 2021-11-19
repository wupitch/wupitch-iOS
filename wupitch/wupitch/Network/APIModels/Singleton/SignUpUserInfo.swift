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
    // 회원가입 에이피아이에 한번에 넣어줄 값
    var isPushAgree : Bool?
    var email : String?
    var password : String?
    var nickname : String?
    var introduce : String?
    
    // 크루 생성하는 에이피아이에 한번에 넣어줄 값 싱글톤으로 받기
    // 스포츠 버튼 눌렸을 때 전달할 값
    var clickSportsBtn : Int?
    // 피커로 지역선택하면 전달할 값
    var selectAreaPicker : Int?
    // 크루만들기 기본정보
    var crewName : String?
    var crewCount : Int?
    var ageList : [Int] = [1,2,3,4,5]
    var extraInfoList : [Int] = [1,2,3,4,5,6,7,8]
    
    
    // 스포츠 조회에 넣을 싱글톤 -> id값
    var sports : [Int] = [1,2,3,4,5,6,7]
    // 지역 조회에 넣을 싱글톤 -> id값
    var areas : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]
    // 지역 조회에 넣을 싱글톤 -> name값
    var areaName : [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26"]
    // 추가 정보 조회에 넣을 싱글톤 -> id값
    var extraInfo : [Int] = [1,2,3,4,5,6,7,8]
    
    
    
    // ------------------------
    
    
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
    
    
    
    // 크루만들기 포토부분
    var photo : UIImage?
    var title : String?
    var crewInfo : String?
    var materials : String?
    var question : String?
    
    func dispose() {
        //SignUpUserInfo.shared.region = nil
        SignUpUserInfo.shared.etcText = nil
        SignUpUserInfo.shared.age = nil
        //SignUpUserInfo.shared.nickName = nil
        //SignUpUserInfo.shared.userIntroduce = nil
        SignUpUserInfo.shared.idImg = nil
    }
    
    private init(){}
}
