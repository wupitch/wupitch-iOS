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
    var email : String = ""
    var password : String = ""
    var nickname : String = ""
    var introduce : String = ""
    
    // 크루 생성하는 에이피아이에 한번에 넣어줄 값 싱글톤으로 받기
    // 무조건 있어야하는 값 + 0번은 다 없는 값이니까 이걸로 초기화
    // 스포츠 버튼 눌렸을 때 전달할 값
    var clickSportsBtn : Int = 0
    // 피커로 지역선택하면 전달할 값
    var selectAreaPicker : Int = 0
    // 크루만들기 기본정보
    var crewName : String = ""
    var crewCount : Int = 0
    var ageList : [Int] = []
    // 정기일정정보
    var date: Int?
    
    // nil로 보내야 하는 값
    // 지역과 장소 고르는 곳에서 장소
    var location : String?
    // 크루 기본정보에서 추가정보(선택)
    var extraInfoList : [Int]?
    // 크루 만들기 포토 부분
    var title : String?
    var crewInfo : String?
    var question : String?
    var photo : UIImage?
    var basicphoto : UIImage?
    var materials : String?
    // 크루만들기 회비
    var money : Int?
    // 크루만들기 손님비
    var guestMoney : Int?
    // 정기 일정 스케줄
    var schedules: [ScheduleList]?
    
    // 크루조회
    var ageListBtn: [Int]?
    var areaIdBtn: Int?
    var daysBtn: [Int]?
    var isAsc: Bool?
    var memberCountValueBtn: Int?
    var page: Int?
    var size: Int?
    var sortBy: String?
    var sportsListBtn: [Int]?

    
    // -----------------------
    
    // 번개생성에 한번에 넣어줄 값
    // 무조건 있어야 하는 값
    // 지역
    var bungaeSelectAreaId : Int = 0
    // 날짜,시간
    var bungaeDate : String = ""
    var bungaeStartTime : Double = 0
    var bungaeEndTime : Double = 0
    // 사진부분
    var bungaeIntroduction: String = ""
    var bungaeInquiries: String = ""
    //모집인원
    var bungaeCount : Int = 0
    
    // 없어도 되는 값
    // 지역
    var bungaeLocation : String?
    // 사진부분
    var bungaeTitle: String?
    var bungaeMaterials :  String?
    var bungaePhoto : UIImage?
    var bungaeBasicPhoto : UIImage?
    // 참여비
    var bungaeDues : Int?
    
    // ---------------------
    
    
    // 스포츠 조회에 넣을 싱글톤 -> id값
    var sports : [Int]?
    // 지역 조회에 넣을 싱글톤 -> id값
    var areas : [Int]?
    // 지역 조회에 넣을 싱글톤 -> name값
    var areaName : [String]?
    var bungaeAreaName : [String]?
    // 추가 정보 조회에 넣을 싱글톤 -> id값
    var extraInfo : [Int]?

    
    // 크루 검색에 한번에 넣어줄 값
    var crewSearchContent: [CrewContent] = []
    
    // 번개 검색 한번에 넣어줄 값
    var bungaeSearchContent: [BungaeSearchContent] = []
    
    // 크루 디테일 바텀시트에 넣어줄 값
    var bottomDates: [Schedule] = []

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
