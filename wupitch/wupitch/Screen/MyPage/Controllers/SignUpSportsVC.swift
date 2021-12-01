//
//  SignUpThirdVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

class SignUpSportsVC: UIViewController {
    
    // MARK: - IBOulets
    @IBOutlet var sportBtns: [SportsBtn]!
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    let maxLength = 20
    var etcTextFieldState : Bool?
    var etcBtnState : Bool?
    lazy var memberSportsDataManager = MemberSportsService()
    lazy var informationDataManager = InformationService()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        memberSportsDataManager.getMemberSports(delegate: self)
        
    }
    
    // set style
    private func setStyle() {
        // titleLabel Style
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.tintColor = .bk
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 35.adjusted)
        
        // description Style
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 20.adjusted)
        descriptionLabel.textColor = .gray02
        
        for i in 0...5 {
            sportBtns[i].btnId = i+1
            print(sportBtns[i].btnId)
        }
        
    }
    
    // MARK: - IBActions
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
//    SignUpUserInfo.shared.ageList = []
//    SignUpUserInfo.shared.extraInfoList = []
//    for i in 0...4 {
//        if ageBtns[i].status == true {
//            SignUpUserInfo.shared.ageList?.append(ageBtns[i].ageInt!)
//            print("연령대 >>>>>>>>>",SignUpUserInfo.shared.ageList)
//        }
//    }
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            SignUpUserInfo.shared.sportsListBtn = []
            for i in 0...5 {
                if sportBtns[i].status == true {
                    SignUpUserInfo.shared.sportsListBtn?.append(sportBtns[i].btnId ?? -99)
                }
                informationDataManager.patchInformation(InformationRequest(sportsList: SignUpUserInfo.shared.sportsListBtn ?? [-99]), delegate: self)
                print("스포츠버튼인덱스", SignUpUserInfo.shared.sportsListBtn)
            }
            
            navigationController?.popViewController(animated: true)
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    // 축구 버튼
    @IBAction func touchUpSoccerBtn(_ sender: UIButton) {
        // 축구 버튼의 색이 default 값일 때
        if sportBtns[0].backgroundColor == .gray04 {
            // 색으로 변경
            sportBtns[0].colorSportsBtn()
            nextBtn.backgroundColor = .main
            // 싱글톤에 값 0으로 저장
//            SignUpUserInfo.shared.sportsList[0]
        }
        // 축구 버튼의 색이 컬러 일 때
        else {
            // 축구 버튼 색 기본색으로 변경
            sportBtns[0].defaultSportsBtn()
            // 싱글톤에 값 초기화
            if sportBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }
    
    // 배드민턴 버튼
    @IBAction func touchUpBadmintonBtn(_ sender: UIButton) {
        sportBtns[1].tag = 2
        // 배드민턴 버튼의 색이 default 값일 때
        if sportBtns[1].backgroundColor == .gray04 {
            // 색으로 변경
            sportBtns[1].colorSportsBtn()
            nextBtn.backgroundColor = .main
            // 싱글톤에 값 1으로 저장
//            SignUpUserInfo.shared.sportsList[1]
        }
        // 배드민턴 버튼의 색이 컬러 일 때
        else {
            // 배드민턴 버튼 색 기본색으로 변경
            sportBtns[1].defaultSportsBtn()
            // 싱글톤에 값 초기화
            if sportBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }
    
    // 배구 버튼
    @IBAction func touchUpVolleyBallBtn(_ sender: UIButton) {
        sportBtns[2].tag = 3
        // 버튼의 색이 default 값일 때
        if sportBtns[2].backgroundColor == .gray04 {
            // 색으로 변경
            sportBtns[2].colorSportsBtn()
            nextBtn.backgroundColor = .main
            // 싱글톤에 값 2으로 저장
//            SignUpUserInfo.shared.sportsList[2]
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[2].defaultSportsBtn()
            // 싱글톤에 값 초기화
            if sportBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }
    
    // 농구 버튼
    @IBAction func touchUpBasketBallBtn(_ sender: Any) {
        sportBtns[3].tag = 4
        // 버튼의 색이 default 값일 때
        if sportBtns[3].backgroundColor == .gray04 {
            // 색으로 변경
            sportBtns[3].colorSportsBtn()
            nextBtn.backgroundColor = .main
            // 싱글톤에 값 3으로 저장
//            SignUpUserInfo.shared.sportsList[3]
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[3].defaultSportsBtn()
            // 싱글톤에 값 초기화
            if sportBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }
    
    // 등산 버튼
    @IBAction func touchUpMountainBtn(_ sender: Any) {
        sportBtns[4].tag = 5
        // 버튼의 색이 default 값일 때
        if sportBtns[4].backgroundColor == .gray04 {
            // 색으로 변경
            sportBtns[4].colorSportsBtn()
            nextBtn.backgroundColor = .main
            // 싱글톤에 값 4으로 저장
//            SignUpUserInfo.shared.sportsList[4]
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[4].defaultSportsBtn()
            // 싱글톤에 값 초기화
            if sportBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }
    
    // 런닝 버튼
    @IBAction func touchUpRunningBtn(_ sender: Any) {
        sportBtns[5].tag = 6
        // 버튼의 색이 default 값일 때
        if sportBtns[5].backgroundColor == .gray04 {
            // 색으로 변경
            sportBtns[5].colorSportsBtn()
            nextBtn.backgroundColor = .main
            // 싱글톤에 값 5로 저장
//            SignUpUserInfo.shared.sportsList[5]
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[5].defaultSportsBtn()
            // 싱글톤에 값 초기화
            if sportBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }
}

// 팝업창
extension SignUpSportsVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 OnbordingVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let onboardingVC = viewController as? OnbordingVC { self.navigationController?.popToViewController(onboardingVC, animated: true)
                SignUpUserInfo.shared.dispose()
            }
        }
    }
}

extension SignUpSportsVC {
    func didSuccessMemberSports(result: MemberSportsResult) {
        print("데이터가 성공적으로 들어왔습니다.")
        
        for i in result.list {
            sportBtns[i.sportsID-1].colorSportsBtn()
        }
    }
    
    // 회원 수정 에이피아이
    func didSuccessInformation(result: InformationData) {
        print("수정한 값이 성공적으로 적용되었습니다.")
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}

