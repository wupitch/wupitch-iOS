//
//  SignInVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/13.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var emailSiginUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }
    
    private func setStyle() {
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
    
    // MARK: - IBActions
    // 이메일로 회원가입 버튼
    @IBAction func touchUpSiginUpBtn(_ sender: Any) {
        // 회원가입 페이지로 이동
        let storyboard = UIStoryboard.init(name: "SignUpTerms", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpTermsVC") as? SignUpTermsVC else {return}
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}
