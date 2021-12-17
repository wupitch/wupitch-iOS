//
//  SignUpEmailPwVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/13.
//

import UIKit

// 이메일,패스워드 뷰
class SignUpEmailPwVC: UIViewController {
    
    // MARK: - IBOutlets
    // 다음 버튼
    @IBOutlet weak var nextBtn: NextBtn!
    
    // 비밀번호 라벨 및 텍스트필드
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // 이메일 라벨 및 텍스트 필드
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    // '이메일과 비번 입력해주세요' 라벪
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Variable
    // 비밀번호 가리기,보이기
    var passwordEyeClick = true
    var passwordEyeBtn = UIButton(type: .system)
    
    var resultIsSuccess : Bool = false
    var pwResultIsSuccess : Bool = false
    
    // MARK: - Server Data Singleton
    lazy var emailValidationManage = EmailValidationService()
    lazy var pwValidationManage = PwValidationService()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
        passwordEyeSecure()
        dismissKeyboardWhenTappedAround()
        passwordTextField.textContentType = .oneTimeCode
    }
    
    // MARK: - Function
    private func setStyle() {
        // emailTextField
        emailTextField.backgroundColor = .gray05
        emailTextField.borderStyle = .none
        emailTextField.makeRounded(cornerRadius: 8.adjusted)
        emailTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        emailTextField.textColor = .gray03
        emailTextField.addLeftPadding()
        
        // passwordTextField
        passwordTextField.backgroundColor = .gray05
        passwordTextField.borderStyle = .none
        passwordTextField.makeRounded(cornerRadius: 8.adjusted)
        passwordTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        passwordTextField.textColor = .gray03
        passwordTextField.addPadding()
        
        // Label
        emailLabel.alpha = 0.0
        passwordLabel.alpha = 0.0
        emailLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        passwordLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.textColor = .bk
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
    }
    
    private func setDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // password eye
    private func passwordEyeSecure() {
        passwordEyeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: passwordTextField.frame.height))
        passwordEyeBtn.setImage(UIImage(named: "viewHide"), for: UIControl.State())
        let container = UIView(frame: passwordEyeBtn.frame)
        container.addSubview(passwordEyeBtn)
        passwordTextField.rightView = container
        passwordTextField.rightViewMode = .always
        
        passwordEyeBtn.addTarget(self, action: #selector(passwordEyeButtonClick), for: .touchUpInside)
    }
    
    // password eye addTarget
    @objc func passwordEyeButtonClick(_ sender: UIButton) {
        if(passwordEyeClick == true) {
            passwordTextField.isSecureTextEntry = false
            passwordEyeBtn.setImage(UIImage(named: "view"), for: UIControl.State())
        } else {
            passwordTextField.isSecureTextEntry = true
            passwordEyeBtn.setImage(UIImage(named: "viewHide"), for: UIControl.State())
        }
        passwordEyeClick = !passwordEyeClick
    }
    
    // MARK: - IBActions
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if  nextBtn.backgroundColor == .main {
            
            // 다음 버튼 클릭 시, 싱글톤에 이메일, 패스워드 넣어주기
            UserDefaults.standard.set(emailTextField.text, forKey: "email")
            SignUpUserInfo.shared.email = emailTextField.text ?? ""
            SignUpUserInfo.shared.password = passwordTextField.text ?? ""
            print("이메일 >>>>>>>>>>",SignUpUserInfo.shared.email)
            print("비밀번호 >>>>>>>>>>",SignUpUserInfo.shared.password)
            
            //버튼 클릭 시, 다음 스토리보드로 이동
            let storyboard = UIStoryboard.init(name: "SignUpProfile", bundle: nil)
            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpProfileVC") as? SignUpProfileVC else {return}
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    // 엑스 버튼
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        // 취소 버튼 클릭 시, 팝업 창 띄워줌
        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
            dvc.modalPresentationStyle = .overFullScreen
            dvc.modalTransitionStyle = .crossDissolve
            // 취소버튼 눌렸을 때 효과 나오기위해
            dvc.alertDelegate = self
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    // 뒤로가기 버튼
    @IBAction func touxhUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Extension
extension SignUpEmailPwVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField.textColor = .bk
        passwordTextField.textColor = .bk
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.resignFirstResponder() {
            emailValidationManage.postEmailValidation(EmailValidationRequest(email: emailTextField.text ?? "값없어요"), delegate: self)
        }
        else {
            pwValidationManage.postPwValidation(PwValidationRequest(password: passwordTextField.text ?? "값없어요"), delegate: self)
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Delegate
// 팝업창 Delegate
extension SignUpEmailPwVC : AlertDelegate {
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

// 이메일, 패스워드 중복 api 연결
extension SignUpEmailPwVC {
    func didSuccessEmailValidation(result: EmailValidationData) {
        print("데이터가 성공적으로 들어왔습니다.")
        print(result.isSuccess)
        
        resultIsSuccess = result.isSuccess
        
        if result.isSuccess == false {
            emailLabel.alpha = 1
            emailLabel.text = "사용 불가능한 이메일입니다."
            emailLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
            emailLabel.textColor = UIColor(red: 241/255, green: 0/255, blue: 0/255, alpha: 1)
            nextBtn.backgroundColor = .gray03
        }
        else {
            emailLabel.alpha = 1
            emailLabel.text = "사용 가능한 이메일입니다."
            emailLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
            emailLabel.textColor = UIColor(red: 72/255, green: 190/255, blue: 0/255, alpha: 1)
            if pwResultIsSuccess == true {
                nextBtn.backgroundColor = .main
            }
        }
    }
        
    func didSuccessPwValidation(result: PwValidationData) {
        print("데이터가 성공적으로 들어왔습니다.")
        print(result.isSuccess)
        
        pwResultIsSuccess = result.isSuccess
        
        if result.isSuccess == false {
            passwordLabel.alpha = 1
            passwordLabel.text = "사용하실 수 없는 비밀번호입니다."
            passwordLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
            passwordLabel.textColor = UIColor(red: 241/255, green: 0/255, blue: 0/255, alpha: 1)
            nextBtn.backgroundColor = .gray03
        }
        else {
            passwordLabel.alpha = 1
            passwordLabel.text = "사용 가능한 비밀번호입니다."
            passwordLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
            passwordLabel.textColor = UIColor(red: 72/255, green: 190/255, blue: 0/255, alpha: 1)
            if resultIsSuccess == true {
                nextBtn.backgroundColor = .main
            }
        }
    }

    func failedToEmailRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}
