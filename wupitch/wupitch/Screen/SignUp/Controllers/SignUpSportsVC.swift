//
//  SignUpThirdVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

class SignUpSportsVC: UIViewController {
    
    // MARK: - IBOulets
    @IBOutlet weak var modalBgView: UIView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet var sportBtns: [SportsBtn]!
    @IBOutlet weak var etcTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var textCount: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        etcTextField.delegate = self
        setStyle()
        modalBgView.alpha = 0.0
        
        // 키보드
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 키보드 올라가는거
    @objc
    func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -100 // Move view 150 points upward
    }
    
    // 키보드 내리는거 (원래 상태로 복귀)
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    // set style
    func setStyle() {
        // textField Style
        etcTextField.alpha = 0.0
        etcTextField.attributedPlaceholder = NSAttributedString(string: "기타 스포츠를 입력해주세요. (선택)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray03])
        etcTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        // textCount
        textCount.alpha = 0.0
        textCount.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        
        // textView
        textView.alpha = 0.0
        
        // titleLabel Style
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.tintColor = .bk
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        
        // description Style
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 20.adjusted)
        
        // nextBtn
        nextBtn.layer.cornerRadius = 8
        nextBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        
        if let loginMethod = SignUpUserInfo.shared.loginMethod {
            switch loginMethod {
            case .kakao:
                nextBtn.setTitle("다음 (3/5)", for: .normal)
            case .apple:
                nextBtn.setTitle("다음 (3/6)", for: .normal)
            }
        }
    }
    
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // x 버튼
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
    
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            let storyboard = UIStoryboard.init(name: "SignUpAge", bundle: nil)
            
            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpAgeVC") as? SignUpAgeVC else {return}
            
            self.navigationController?.pushViewController(dvc, animated: true)
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
            // 모달창 올라오삼
            let storyBoard: UIStoryboard = UIStoryboard(name: "LevelModal", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LevelModalVC") as? LevelModalVC {
                dvc.modalPresentationStyle = .overFullScreen
                // 모달 백그라운드
                modalBgView.alpha = 1
                dvc.levelModalDelegate = self
                dvc.btnIndex = 0
                self.present(dvc, animated: true, completion: nil)
            }
        }
        // 축구 버튼의 색이 컬러 일 때
        else {
            // 축구 버튼 색 기본색으로 변경
            sportBtns[0].defaultSportsBtn()
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
            // 모달창 올라오삼
            let storyBoard: UIStoryboard = UIStoryboard(name: "LevelModal", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LevelModalVC") as? LevelModalVC {
                dvc.modalPresentationStyle = .overFullScreen
                // 모달 백그라운드
                modalBgView.alpha = 1
                dvc.btnIndex = 1
                dvc.levelModalDelegate = self
                self.present(dvc, animated: true, completion: nil)
            }
        }
        // 배드민턴 버튼의 색이 컬러 일 때
        else {
            // 배드민턴 버튼 색 기본색으로 변경
            sportBtns[1].defaultSportsBtn()
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
            // 모달창 올라오삼
            let storyBoard: UIStoryboard = UIStoryboard(name: "LevelModal", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LevelModalVC") as? LevelModalVC {
                dvc.modalPresentationStyle = .overFullScreen
                // 모달 백그라운드
                modalBgView.alpha = 1
                dvc.btnIndex = 2
                dvc.levelModalDelegate = self
                self.present(dvc, animated: true, completion: nil)
            }
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[2].defaultSportsBtn()
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
            // 모달창 올라오삼
            let storyBoard: UIStoryboard = UIStoryboard(name: "LevelModal", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LevelModalVC") as? LevelModalVC {
                dvc.modalPresentationStyle = .overFullScreen
                // 모달 백그라운드
                modalBgView.alpha = 1
                dvc.btnIndex = 3
                dvc.levelModalDelegate = self
                self.present(dvc, animated: true, completion: nil)
            }
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[3].defaultSportsBtn()
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
            // 모달창 올라오삼
            let storyBoard: UIStoryboard = UIStoryboard(name: "LevelModal", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LevelModalVC") as? LevelModalVC {
                dvc.modalPresentationStyle = .overFullScreen
                // 모달 백그라운드
                modalBgView.alpha = 1
                dvc.btnIndex = 4
                dvc.levelModalDelegate = self
                self.present(dvc, animated: true, completion: nil)
            }
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[4].defaultSportsBtn()
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
            // 모달창 올라오삼
            let storyBoard: UIStoryboard = UIStoryboard(name: "LevelModal", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LevelModalVC") as? LevelModalVC {
                dvc.modalPresentationStyle = .overFullScreen
                // 모달 백그라운드
                modalBgView.alpha = 1
                dvc.levelModalDelegate = self
                dvc.btnIndex = 5
                self.present(dvc, animated: true, completion: nil)
            }
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[5].defaultSportsBtn()
            if sportBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }
    
    // 기타 버튼
    @IBAction func etcBtn(_ sender: UIButton) {
        sportBtns[6].tag = 7
        // 버튼의 색이 default 값일 때
        if sportBtns[6].backgroundColor == .gray04 {
            // 색으로 변경
            sportBtns[6].colorSportsBtn()
            etcTextField.alpha = 1
            textCount.alpha = 1
            textView.alpha = 1
            nextBtn.backgroundColor = .main
        }
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[6].defaultSportsBtn()
            etcTextField.alpha = 0.0
            textCount.alpha = 0.0
            textView.alpha = 0.0
            // 버튼이 몇개가 눌려있나 점검 -> 한개도 없으면 다음 버튼 비활성화
            if sportBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }
}

extension SignUpSportsVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // backspace 감지하기
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        // 글자수제한
        guard textField.text!.count < 21
                
        else {
            return false
        }
        textCount.text = "\(textField.text?.count ?? 0)" + "/20"
        
        return true
    }
    // 리턴버튼 누르면 키보드 사라짐
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        etcTextField.resignFirstResponder()
        return true
    }
}

extension SignUpSportsVC: LevelModalDelegate {
    func levelModalDismiss(index: Int) {
        modalBgView.alpha = 0.0
        sportBtns[index].defaultSportsBtn()
    }
    
    func completeBtnToNextBtn() {
        nextBtn.backgroundColor = .main
        modalBgView.alpha = 0.0

    }
}

extension SignUpSportsVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 OnbordingVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let onboardingVC = viewController as? OnbordingVC { self.navigationController?.popToViewController(onboardingVC, animated: true)
            }
        }
    }
}
