//
//  SignUpAgeVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/27.
//

import UIKit

class SignUpAgeVC: UIViewController {
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet var ageBtns: [SportsBtn]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
    }
    
    func setStyle() {
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        
        nextBtn.layer.cornerRadius = 8.adjusted
        nextBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        nextBtn.backgroundColor = .gray03
        
        if let loginMethod = SignUpUserInfo.shared.loginMethod {
            switch loginMethod {
            case .kakao:
                nextBtn.setTitle("다음 (4/5)", for: .normal)
            case .apple:
                nextBtn.setTitle("다음 (4/6)", for: .normal)
            }
        }
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            let storyboard = UIStoryboard.init(name: "SignUpProfile", bundle: nil)
            
            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpProfileVC") as? SignUpProfileVC else {return}
            
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        // 취소 버튼 클릭 시, 팝업 창 띄워줌
        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
        
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
            dvc.modalPresentationStyle = .overFullScreen
            dvc.modalTransitionStyle = .crossDissolve
            
            dvc.alertDelegate = self
            
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    @IBAction func touchUpFirstBtn(_ sender: Any) {
        ageBtns[0].colorSportsBtn()
        nextBtn.backgroundColor = .main
        if ageBtns[0].status {
            ageBtns[1].defaultSportsBtn()
            ageBtns[2].defaultSportsBtn()
            ageBtns[3].defaultSportsBtn()
            ageBtns[4].defaultSportsBtn()
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
