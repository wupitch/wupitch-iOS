//
//  SignUpAgeVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/27.
//

import UIKit
import Alamofire

class SignUpAgeVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet var ageBtns: [SportsBtn]!
    
    lazy var memberAgeDataManager = MemberAgeService()
    lazy var ageInformationDataManager = AgeInformationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        memberAgeDataManager.getMemberAge(delegate: self)
        
    }
    
    func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 35.adjusted)
    }
    
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            
            print("<<<<<<<<<싱글톤 값 잘 받아와지나 확인>>>>>>>>>")
            print("연령대 : ", SignUpUserInfo.shared.age ?? "값이 없습니다.")
            
            ageInformationDataManager.patchInformation(AgeInformationRequest(ageNum: SignUpUserInfo.shared.age ?? -1), delegate: self)
            
            navigationController?.popViewController(animated: true)
        }
        
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpFirstBtn(_ sender: Any) {
        ageBtns[0].colorSportsBtn()
        nextBtn.backgroundColor = .main
        if ageBtns[0].status {
            ageBtns[1].defaultSportsBtn()
            ageBtns[2].defaultSportsBtn()
            ageBtns[3].defaultSportsBtn()
            ageBtns[4].defaultSportsBtn()
            SignUpUserInfo.shared.age = 1
        }
    }
    
    @IBAction func touchUpSecondBtn(_ sender: Any) {
        ageBtns[1].colorSportsBtn()
        nextBtn.backgroundColor = .main
        if ageBtns[1].status {
            ageBtns[0].defaultSportsBtn()
            ageBtns[2].defaultSportsBtn()
            ageBtns[3].defaultSportsBtn()
            ageBtns[4].defaultSportsBtn()
            SignUpUserInfo.shared.age = 2
        }
    }
    
    @IBAction func touchUpThirdBtn(_ sender: Any) {
        ageBtns[2].colorSportsBtn()
        nextBtn.backgroundColor = .main
        if ageBtns[2].status {
            ageBtns[0].defaultSportsBtn()
            ageBtns[1].defaultSportsBtn()
            ageBtns[3].defaultSportsBtn()
            ageBtns[4].defaultSportsBtn()
            SignUpUserInfo.shared.age = 3
        }
    }
    
    @IBAction func touchUpFourthBtn(_ sender: Any) {
        ageBtns[3].colorSportsBtn()
        nextBtn.backgroundColor = .main
        if ageBtns[3].status {
            ageBtns[0].defaultSportsBtn()
            ageBtns[1].defaultSportsBtn()
            ageBtns[2].defaultSportsBtn()
            ageBtns[4].defaultSportsBtn()
            SignUpUserInfo.shared.age = 4
        }
    }
    
    @IBAction func touchUpFifthBtn(_ sender: Any) {
        ageBtns[4].colorSportsBtn()
        nextBtn.backgroundColor = .main
        if ageBtns[4].status {
            ageBtns[0].defaultSportsBtn()
            ageBtns[1].defaultSportsBtn()
            ageBtns[2].defaultSportsBtn()
            ageBtns[3].defaultSportsBtn()
            SignUpUserInfo.shared.age = 5
        }
    }
}

extension SignUpAgeVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 OnbordingVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let onboardingVC = viewController as? OnbordingVC { self.navigationController?.popToViewController(onboardingVC, animated: true)
            }
        }
    }
}

extension SignUpAgeVC {
    func didSuccessMemberAge(result: MemberAgeResult) {
        print("데이터가 성공적으로 들어왔습니다.")
        
        ageBtns[result.ageIdx-1].colorSportsBtn()
    }
    
    // 회원 수정 에이피아이
    func didSuccessInformation(result: InformationData) {
        print("수정한 값이 성공적으로 적용되었습니다.")
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}

