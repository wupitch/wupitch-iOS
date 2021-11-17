//
//  SignInVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/13.
//

import UIKit
import KakaoSDKCommon

class SignInVC: UIViewController {

    @IBOutlet weak var emailSiginUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    lazy var signInManager = SignInService()
    var isMessage : String = ""
    var isSuccess : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        
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
    
    private func setStyle() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.backgroundColor = .gray05
        emailTextField.borderStyle = .none
        emailTextField.makeRounded(cornerRadius: 22.adjusted)
        emailTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        emailTextField.textColor = .gray03
        emailTextField.loginVIewPadding()
        
        passwordTextField.backgroundColor = .gray05
        passwordTextField.borderStyle = .none
        passwordTextField.makeRounded(cornerRadius: 22.adjusted)
        passwordTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        passwordTextField.textColor = .gray03
        passwordTextField.loginVIewPadding()
        
        loginBtn.makeRounded(cornerRadius: 22.adjusted)
        
        emailSiginUpBtn.makeRounded(cornerRadius: 22.adjusted)
        emailSiginUpBtn.layer.borderWidth = 1.adjusted
        emailSiginUpBtn.layer.borderColor = UIColor.main.cgColor
    }
    
    private func alertSheet(message : String) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler : nil )
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler : nil)
        
        alert.addAction(cancel)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    
    // 로그인버튼
    @IBAction func touchUpSignInBtn(_ sender: Any) {
        
        guard let email = emailTextField.text?.trim, email.isExists else {
            self.presentAlert(title: "아이디를 입력해주세요.")
            return
        }
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
        let storyboard = UIStoryboard.init(name: "Crew", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "CrewVC") as? CrewVC else {return}
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
        print("데이터가 들어오지 않았습니다.")
        // 로그인 실패 시 저장했던 값 없애주기
        UserDefaults.standard.removeObject(forKey: "userToken")
    }
}

