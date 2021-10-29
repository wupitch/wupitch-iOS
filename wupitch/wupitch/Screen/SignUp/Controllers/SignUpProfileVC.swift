//
//  SignUpFourthVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

class SignUpProfileVC: UIViewController {
    
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var textCountLabel: UILabel!
    
    let maxLength = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        placeholderSetting()
        
        nickNameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange(_:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: nickNameTextField)
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = nickNameTextField.text {
                
                if text.count > maxLength {
                    // 8글자 넘어가면 자동으로 키보드 내려감
                    nickNameTextField.resignFirstResponder()
                }
                
                // 초과되는 텍스트 제거
                if text.count >= maxLength {
                    let index = text.index(text.startIndex, offsetBy: maxLength)
                    let newString = text[text.startIndex..<index]
                    nickNameTextField.text = String(newString)
                }
                
                // 2글자 이상 8글자 이하로 입력해주세요
                // 중복검사해야함 뭘로해? api?받나?
                else if text.count < 2 {
                    correctLabel.alpha = 1
                    correctLabel.text = "사용 불가능한 닉네임입니다."
                    correctLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
                    correctLabel.textColor = UIColor(red: 241/255, green: 0/255, blue: 0/255, alpha: 1)
                    startBtn.backgroundColor = .gray03
                    
                }
                else {
                    correctLabel.alpha = 1
                    correctLabel.text = "사용 가능한 닉네임입니다."
                    correctLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
                    correctLabel.textColor = UIColor(red: 72/255, green: 190/255, blue: 0/255, alpha: 1)
                    startBtn.backgroundColor = .main
                }
            }
        }
    }
    
    func placeholderSetting() {
        infoTextView.delegate = self
        infoTextView.text = "자기소개를 입력해주세요."
        infoTextView.textColor = .gray03
    }
    
    
    func setStyle() {
        // 확인 라벨 처음엔 안보이게
        correctLabel.alpha = 0.0
        
        // titleLabel Style
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        
        // nicknameTextField Style
        nickNameTextField.backgroundColor = .gray05
        nickNameTextField.borderStyle = .none
        nickNameTextField.layer.cornerRadius = 8
        nickNameTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        nickNameTextField.textColor = .gray02
        nickNameTextField.addLeftPadding()
        
        // textView Style
        infoTextView.backgroundColor = .gray05
        infoTextView.layer.cornerRadius = 8
        infoTextView.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        infoTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        // textcountLabel Style
        textCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        textCountLabel.textColor = .gray03
        
        // startBtn Style
        startBtn.layer.cornerRadius = 8
        startBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        
        if let loginMethod = SignUpUserInfo.shared.loginMethod {
            switch loginMethod {
            case .kakao:
                startBtn.setTitle("완료", for: .normal)
            case .apple:
                startBtn.setTitle("다음 (5/6)", for: .normal)
            }
        }
        
    }
    
    // backBtn
    @IBAction func touchUpBackBtn(_ sender: Any) {
        print("뒤로가기")
        navigationController?.popViewController(animated: true)
    }
    
    // cancelBtn
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
    
    // startBtn
    @IBAction func touchUpStartBtn(_ sender: Any) {
        // 카카오 로그인 루트로 들어왔을 때
        if startBtn.backgroundColor == .main {
            if let loginMethod = SignUpUserInfo.shared.loginMethod {
                switch loginMethod {
                case .kakao:
                    startBtn.setTitle("완료", for: .normal)
                    let storyboard = UIStoryboard.init(name: "SignUpKakaoComplete", bundle: nil)
                    
                    guard let dvc = storyboard.instantiateViewController(identifier: "SignUpKakaoCompleteVC") as? SignUpKakaoCompleteVC else {return}
                    
                    self.navigationController?.pushViewController(dvc, animated: true)
                    
                case .apple:
                    startBtn.setTitle("다음 (5/6)", for: .normal)
                    // 애플 루트로 들어왔을 때
                    let storyboard = UIStoryboard.init(name: "SignUpID", bundle: nil)
                    
                    guard let dvc = storyboard.instantiateViewController(identifier: "SignUpIDVC") as? SignUpIDVC else {return}
                    
                    self.navigationController?.pushViewController(dvc, animated: true)
                }
            }
            else {
                startBtn.backgroundColor = .gray03
            }
        }
    }
}

extension SignUpProfileVC: UITextViewDelegate, UITextFieldDelegate, AlertDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray03 {
            textView.text = nil
            textView.textColor = .gray02
        }
      }

      func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
          textView.text = "내용을 입력해주세요."
            textView.textColor = .gray03
        }
      }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 최대 100자
        guard infoTextView.text!.count <= 100 else { return false }
        
        textCountLabel.text = "\(infoTextView.text?.count ?? 0)" + "/100"
        textCountLabel.textColor = .gray03
        textCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        
        return true
    }
    
    // UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // backspace 감지하기
//        if let char = string.cString(using: String.Encoding.utf8) {
//            let isBackSpace = strcmp(char, "\\b")
//            if isBackSpace == -92 {
//                return true
//            }
//        }
        
        // 글자수제한 (최대 6자)
        guard nickNameTextField.text!.count <= 5 else { return false }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nickNameTextField.resignFirstResponder()
        return true
    }
    
   
    
    
//    // UITextView Placeholder
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if infoTextView.textColor == .gray02 {
//            infoTextView.text = nil
//            infoTextView.textColor = .gray02
//        }
//    }
//    // TextView Place Holder
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if infoTextView.text.isEmpty {
//            infoTextView.text = "자기소개를 입력해주세요."
//            infoTextView.textColor = .gray02
//        }
//    }
    
    // AlertDelegate
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 OnbordingVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let onboardingVC = viewController as? OnbordingVC { self.navigationController?.popToViewController(onboardingVC, animated: true)
            }
        }
    }
}




