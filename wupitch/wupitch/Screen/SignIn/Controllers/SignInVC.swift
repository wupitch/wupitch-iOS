//
//  SignInVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/13.
//

import UIKit

// 로그인 뷰
class SignInVC: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet weak var emailSiginUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Variable
    lazy var signInManager = SignInService()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
        setKeyboard()
        dismissKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setViewControllers([self], animated: true)
    }
    
    // MARK: - Function
    private func setStyle() {
        // emailTextField
        emailTextField.backgroundColor = .gray05
        emailTextField.borderStyle = .none
        emailTextField.makeRounded(cornerRadius: 22.adjusted)
        emailTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        emailTextField.textColor = .gray03
        emailTextField.loginVIewPadding()
        
        // passwordTextField
        passwordTextField.backgroundColor = .gray05
        passwordTextField.borderStyle = .none
        passwordTextField.makeRounded(cornerRadius: 22.adjusted)
        passwordTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        passwordTextField.textColor = .gray03
        passwordTextField.loginVIewPadding()
        
        // signInBtn
        loginBtn.makeRounded(cornerRadius: 22.adjusted)
        
        // signUpBtn
        emailSiginUpBtn.makeRounded(cornerRadius: 22.adjusted)
        emailSiginUpBtn.layer.borderWidth = 1.adjusted
        emailSiginUpBtn.layer.borderColor = UIColor.main.cgColor
    }
    
    private func setDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setKeyboard() {
        // 키보드 show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 키보드 hide
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

    // MARK: - IBActions
    // 로그인버튼
    @IBAction func touchUpSignInBtn(_ sender: Any) {
        // 이메일에 아무것도 입력되지 않았을 때
        guard let email = emailTextField.text?.trim, email.isExists else {
            self.presentAlert(title: "아이디를 입력해주세요.")
            return
        }
        // 패스워드에 아무것도 입력되지 않았을 때
        guard let password = passwordTextField.text?.trim, password.isExists else {
            self.presentAlert(title: "비밀번호를 입력해주세요.")
            return
        }
        let input = SignInRequest(email: email, password: password)
        signInManager.postSignIn(input, delegate: self)
    }

    // 이메일로 회원가입 버튼
    @IBAction func touchUpSiginUpBtn(_ sender: Any) {
        // 회원가입 페이지로 이동
        let storyboard = UIStoryboard.init(name: "SignUpTerms", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpTermsVC") as? SignUpTermsVC else {return}
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - Extension
extension SignInVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField.textColor = .bk
        passwordTextField.textColor = .bk
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

// 로그인 api 연결
extension SignInVC {
    func didSuccessSignIn(result: SignInResult) {
        print("데이터가 성공적으로 들어왔습니다.")
        
        // 토큰 저장
        UserDefaults.standard.string(forKey: "userToken")
        
        // 회원가입 페이지로 이동
        let storyboard = UIStoryboard.init(name: "Tabbar", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "TabbarVC") as? TabbarVC else {return}
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
        print("데이터가 들어오지 않았습니다.")
        // 로그인 실패 시 저장했던 값 없애주기
        UserDefaults.standard.removeObject(forKey: "userToken")
    }
}

