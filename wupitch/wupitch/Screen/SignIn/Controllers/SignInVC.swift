//
//  SignInVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/13.
//

import UIKit
import Alamofire

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
        UserDefaults.standard.set(result.jwt, forKey: "userToken")
        
        if (UserDefaults.standard.string(forKey: "userToken") != nil) {
            let url = "https://dev.yogiyo-backend.shop/app/accounts/auth"
            //let url = "https://prod.wupitch.site/app/accounts/auth"
            
            var header : HTTPHeaders = []
            if let token = UserDefaults.standard.string(forKey: "userToken") {
                header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
            }
            else {
                header = ["Content-Type":"application/json"]
            }
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
                .responseDecodable(of: MemberInfoData.self) { response in
                    switch response.result {
                    case .success(let response):
                        print("신분증 인증 데이터가 성공적으로 들어왔어요.", response.result)
                        // 유저디폴트에 신분증 체크여부 저장
                        UserDefaults.standard.set(response.result.isChecked, forKey: "isCheckdeId")
                        // 신분증 인증이 승인 났을 때만 홈으로 이동
                        if response.result.isChecked == true {
                            print("신분증 인증이 완료된 사용자입니다.", response.result.isChecked)
                            // 홈으로 이동
                            let storyboard = UIStoryboard.init(name: "Tabbar", bundle: nil)
                            guard let dvc = storyboard.instantiateViewController(identifier: "TabbarVC") as? TabbarVC else {return}
                            self.navigationController?.pushViewController(dvc, animated: true)
                        }
                        else {
                            self.presentAlert(title: "신분증 인증", message: "신분증이 인증되지 않았습니다. 조금만 기다려주세요!", isCancelActionIncluded: false, preferredStyle: .alert, handler: nil)
                        }
                        
                    case .failure(let error):
                        print("로그인 시 데이터를 가져오는 곳에서 오류가 났습니다",error.localizedDescription)
                    }
                }
        }
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
        print("데이터가 들어오지 않았습니다.")
        // 로그인 실패 시 저장했던 값 없애주기
        UserDefaults.standard.removeObject(forKey: "userToken")
    }
}
