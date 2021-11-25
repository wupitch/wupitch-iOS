//
//  ProfilePasswordVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/25.
//

import UIKit

class ProfilePasswordVC: UIViewController {

    // MARK: - IBOutlets
    // 다음 버튼
    @IBOutlet weak var nextBtn: NextBtn!
    
    // 현재 비밀번호 라벨 및 텍스트필드
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // 변경할 비밀번호 라벨 및 텍스트 필드
    @IBOutlet weak var changePwLabel: UILabel!
    @IBOutlet weak var changePwTextField: UITextField!
    
    // MARK: - Variable
    // 비밀번호 가리기,보이기
    var passwordEyeClick = true
    var passwordEyeBtn = UIButton(type: .system)
    
    var resultIsSuccess : Bool = false
    var pwResultIsSuccess : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setDelegate()
        passwordEyeSecure()
    }
    
    // MARK: - Function
    private func setStyle() {
        // emailTextField
        changePwTextField.backgroundColor = .gray05
        changePwTextField.borderStyle = .none
        changePwTextField.makeRounded(cornerRadius: 8.adjusted)
        changePwTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        changePwTextField.textColor = .gray03
        changePwTextField.addLeftPadding()
        
        // passwordTextField
        passwordTextField.backgroundColor = .gray05
        passwordTextField.borderStyle = .none
        passwordTextField.makeRounded(cornerRadius: 8.adjusted)
        passwordTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        passwordTextField.textColor = .gray03
        passwordTextField.addPadding()
        
        // Label
        changePwLabel.alpha = 0.0
        passwordLabel.alpha = 0.0
        changePwLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        changePwLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
    }
    
    private func setDelegate() {
        changePwTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // password eye
    private func passwordEyeSecure() {
        passwordEyeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: passwordTextField.frame.height))
        passwordEyeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: changePwTextField.frame.height))
        passwordEyeBtn.setImage(UIImage(named: "viewHide"), for: UIControl.State())
        let container = UIView(frame: passwordEyeBtn.frame)
        container.addSubview(passwordEyeBtn)
        passwordTextField.rightView = container
        passwordTextField.rightViewMode = .always
        changePwTextField.rightView = container
        changePwTextField.rightViewMode = .always
        
        passwordEyeBtn.addTarget(self, action: #selector(passwordEyeButtonClick), for: .touchUpInside)
        
        passwordEyeBtn.addTarget(self, action: #selector(changePasswordEyeButtonClick), for: .touchUpInside)
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
    
    // password eye addTarget
    @objc func changePasswordEyeButtonClick(_ sender: UIButton) {
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
//        if  nextBtn.backgroundColor == .main {
//
//            // 다음 버튼 클릭 시, 싱글톤에 이메일, 패스워드 넣어주기
//            SignUpUserInfo.shared.email = changePwTextField.text
//            SignUpUserInfo.shared.password = passwordTextField.text
//            print("이메일 >>>>>>>>>>",SignUpUserInfo.shared.email ?? "값이 없어요!")
//            print("비밀번호 >>>>>>>>>>",SignUpUserInfo.shared.password ?? "값이 없어요!")
//
//            //버튼 클릭 시, 다음 스토리보드로 이동
//            let storyboard = UIStoryboard.init(name: "SignUpProfile", bundle: nil)
//            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpProfileVC") as? SignUpProfileVC else {return}
//            self.navigationController?.pushViewController(dvc, animated: true)
//        }
//        else {
//            nextBtn.backgroundColor = .gray03
//        }
    }
    
    // 뒤로가기 버튼
    @IBAction func touxhUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Extension
extension ProfilePasswordVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changePwTextField.textColor = .bk
        passwordTextField.textColor = .bk
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if changePwTextField.resignFirstResponder() {
            if let email = changePwTextField.text {
//                emailValidationManage.postEmailValidation(EmailValidationRequest(email: email), delegate: self)
            }
        }
        else {
            if let password = passwordTextField.text {
//                pwValidationManage.postPwValidation(PwValidationRequest(password: password), delegate: self)
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        changePwTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
