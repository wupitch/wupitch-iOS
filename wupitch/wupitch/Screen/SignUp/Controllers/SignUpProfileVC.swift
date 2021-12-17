//
//  SignUpFourthVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

// 프로필 뷰
class SignUpProfileVC: UIViewController {
    
    // MARK: - IBOulets
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var startBtn: NextBtn!
    @IBOutlet weak var textCountLabel: UILabel!
    
    // MARK: - Variable
    var textViewState : Bool?
    let maxLength = 6
    var resultIsSuccess : Bool = false
    lazy var nicknameValidationManage = NicknameValidationService()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        placeholderSetting()
        setDelegate()
        dismissKeyboardWhenTappedAround()
    }
    
    // MARK: - Funtion
    func setDelegate() {
        nickNameTextField.delegate = self
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
        infoTextView.makeRounded(cornerRadius: 8.adjusted)
        infoTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        infoTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        // textcountLabel Style
        textCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        textCountLabel.textColor = .gray03
    }
    
    // MARK: - IBActions
    // backBtn
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    // 다음버튼
    @IBAction func touchUpStartBtn(_ sender: Any) {
        if startBtn.backgroundColor == .main {
            // 싱글톤에 닉네임, 자기소개 넣어주기
            SignUpUserInfo.shared.nickname = nickNameTextField.text ?? ""
            SignUpUserInfo.shared.introduce = infoTextView.text ?? ""
            print("닉네임 >>>>>>>>>>", SignUpUserInfo.shared.nickname)
            print("자기소개 >>>>>>>>>>", SignUpUserInfo.shared.introduce)
            
            // 다음 스토리 보드로 이동
            let storyboard = UIStoryboard.init(name: "SignUpID", bundle: nil)
            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpIDVC") as? SignUpIDVC else {return}
            self.navigationController?.pushViewController(dvc, animated: true)
            
        }
        else {
            startBtn.backgroundColor = .gray03
        }
    }
}

// MARK: - Extension
extension SignUpProfileVC: UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray03 {
            textViewState = true
            textView.text = nil
            textView.textColor = .bk
            
            if resultIsSuccess == true {
                startBtn.backgroundColor = .main
            }
            else {
                startBtn.backgroundColor = .gray03
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textViewState = false
            textView.text = "자기소개를 입력해주세요."
            textView.textColor = .gray03
            startBtn.backgroundColor = .gray03
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 최대 100자
        guard infoTextView.text!.count <= 100 else { return false }
        
        textCountLabel.text = "\(infoTextView.text?.count ?? 0)" + "/100"
        textCountLabel.textColor = .gray03
        textCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        
        // 엔터버튼 키보드 내려가기
        if text == "\n" {
            textView.resignFirstResponder()
        }
        
        return true
    }
    
    // UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        
        return newLength <= 6
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nickNameTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nicknameValidationManage.postNicknameValidation(NicknameValidationRequest(nickname: nickNameTextField.text ?? "값없음"), delegate: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nickNameTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Delegate
extension SignUpProfileVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 SignInVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let signInVC = viewController as? SignInVC { self.navigationController?.popToViewController(signInVC, animated: true)
                // pop되면서 모든 정보 nil로 초기화
                SignUpUserInfo.shared.dispose()
            }
        }
    }
}

// 닉네임 중복 api 연결
extension SignUpProfileVC {
    func didSuccessNicknameValidation(result: NicknameValidationData) {
        print("데이터가 성공적으로 들어왔습니다.")
        print(result.isSuccess)
        
        resultIsSuccess = result.isSuccess
        
        if result.isSuccess == false {
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
            if textViewState == true {
                startBtn.backgroundColor = .main
            }
        }
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
        
    }
}




