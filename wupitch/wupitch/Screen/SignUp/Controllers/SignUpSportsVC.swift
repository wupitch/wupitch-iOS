//
//  SignUpThirdVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

class SignUpSportsVC: UIViewController {
    
    // MARK: - IBOulets
    @IBOutlet weak var textView: UIView!
    @IBOutlet var sportBtns: [SportsBtn]!
    @IBOutlet weak var etcTextField: UITextField!
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var textCount: UILabel!
    
    let maxLength = 20
    var etcTextFieldState : Bool?
    var etcBtnState : Bool?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        kakaoAppleLoginLogic()
        setTextFieldDelegate()
        
        // 키보드 show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 키보드 hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // 텍스트필드
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange(_:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: etcTextField)
    }
    
//    func set() {
//        if etcBtnState == true {
//            if etcTextFieldState == true {
//                nextBtn.backgroundColor = .main
//            }
//            else {
//                nextBtn.backgroundColor = .gray03
//            }
//        }else {
//            nextBtn.backgroundColor = .main
//        }
//    }
    
    // 텍스트필드
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = etcTextField.text {
                
                if text.count >= maxLength {
                    // 20글자 넘어가면 자동으로 키보드 내려감
                    etcTextField.resignFirstResponder()
                }
                
                // 초과되는 텍스트 제거
                if text.count > maxLength {
                    let index = text.index(text.startIndex, offsetBy: maxLength)
                    let newString = text[text.startIndex..<index]
                    etcTextField.text = String(newString)
                }
            }
        }
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
    
    // setDelegate
    private func setTextFieldDelegate() {
        etcTextField.delegate = self
    }
    
    // set style
    private func setStyle() {
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
        
    }
    
    // 카카오, 애플 로그인 로직 나누기
    private func kakaoAppleLoginLogic() {
        if let loginMethod = SignUpUserInfo.shared.loginMethod {
            switch loginMethod {
            case .kakao:
                nextBtn.setTitle("다음 (3/5)", for: .normal)
            case .apple:
                nextBtn.setTitle("다음 (3/6)", for: .normal)
            }
        }
    }
    
    // MARK: - IBActions
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
            
            print("<<<<<<<<<<<싱글톤 값 잘 들어가나 확인>>>>>>>>>>>")
            print("축구버튼:", SignUpUserInfo.shared.soccer ?? "값이 없습니다.")
            print("배드민턴버튼:", SignUpUserInfo.shared.badminton ?? "값이 없습니다.")
            print("배구버튼:", SignUpUserInfo.shared.volleyball ?? "값이 없습니다.")
            print("농구버튼:", SignUpUserInfo.shared.basketball ?? "값이 없습니다.")
            print("등산버튼:", SignUpUserInfo.shared.mountain ?? "값이 없습니다.")
            print("런닝버튼:", SignUpUserInfo.shared.running ?? "값이 없습니다.")
            print("기타버튼:", SignUpUserInfo.shared.etcText ?? "값이 없습니다.")
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
            SignUpUserInfo.shared.soccer = 0
        }
        // 축구 버튼의 색이 컬러 일 때
        else {
            // 축구 버튼 색 기본색으로 변경
            sportBtns[0].defaultSportsBtn()
            // 싱글톤에 값 초기화
            SignUpUserInfo.shared.soccer = nil
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
            SignUpUserInfo.shared.badminton = 1
        }
        // 배드민턴 버튼의 색이 컬러 일 때
        else {
            // 배드민턴 버튼 색 기본색으로 변경
            sportBtns[1].defaultSportsBtn()
            // 싱글톤에 값 초기화
            SignUpUserInfo.shared.badminton = nil
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
            SignUpUserInfo.shared.volleyball = 2
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[2].defaultSportsBtn()
            // 싱글톤에 값 초기화
            SignUpUserInfo.shared.volleyball = nil
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
            SignUpUserInfo.shared.basketball = 3
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[3].defaultSportsBtn()
            // 싱글톤에 값 초기화
            SignUpUserInfo.shared.basketball = nil
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
            SignUpUserInfo.shared.mountain = 4
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[4].defaultSportsBtn()
            // 싱글톤에 값 초기화
            SignUpUserInfo.shared.mountain = nil
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
            SignUpUserInfo.shared.running = 5
        }
        // 버튼의 색이 컬러 일 때
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[5].defaultSportsBtn()
            // 싱글톤에 값 초기화
            SignUpUserInfo.shared.running = nil
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
            etcBtnState = true
            nextBtn.backgroundColor = .main
        }
        else {
            // 버튼 색 기본색으로 변경
            sportBtns[6].defaultSportsBtn()
            etcTextField.alpha = 0.0
            textCount.alpha = 0.0
            textView.alpha = 0.0
            etcBtnState = false
            // 버튼 해제시 싱글톤 초기화
            SignUpUserInfo.shared.etcText = nil
            
            // 버튼이 몇개가 눌려있나 점검 -> 한개도 없으면 다음 버튼 비활성화
            if sportBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }
}

// textField delegate
extension SignUpSportsVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = etcTextField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        
        textCount.text = "\(newLength)" + "/20"
        
        return newLength <= 20
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("뭐라고나오나보자",etcTextField.text ?? "값없음")
        //etcTextFieldState = true
        //nextBtn.backgroundColor = .main
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 텍스트 싱글톤에 저장
        SignUpUserInfo.shared.etcText = etcTextField.text
        
        if textField.text?.isEmpty == true {
            //etcTextFieldState = false
            //nextBtn.backgroundColor = .gray03
            // 텍스트 싱글톤 초기화
            SignUpUserInfo.shared.etcText = nil
        }
    }
    
    // 리턴버튼 누르면 키보드 사라짐
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        etcTextField.resignFirstResponder()
        return true
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
