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
    var changePasswordEyeBtn = UIButton(type: .system)
    
    var resultIsSuccess : Bool = false
    var pwResultIsSuccess : Bool = false
    
    lazy var passwordCheckDataManager = PasswordCheckService()
    lazy var changePasswordDataManager = ChangePasswordService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setDelegate()
        passwordEyeSecure()
        changePasswordEyeSecure()
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
    
    // password eye
    private func changePasswordEyeSecure() {
        changePasswordEyeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: changePwTextField.frame.height))
        changePasswordEyeBtn.setImage(UIImage(named: "viewHide"), for: UIControl.State())
        let container = UIView(frame: changePasswordEyeBtn.frame)
        container.addSubview(changePasswordEyeBtn)
        changePwTextField.rightView = container
        changePwTextField.rightViewMode = .always
        changePasswordEyeBtn.addTarget(self, action: #selector(changePasswordEyeButtonClick), for: .touchUpInside)
    }
    
    // password eye addTarget
    @objc func changePasswordEyeButtonClick(_ sender: UIButton) {
        if(passwordEyeClick == true) {
            changePwTextField.isSecureTextEntry = false
            changePasswordEyeBtn.setImage(UIImage(named: "view"), for: UIControl.State())
        } else {
            changePwTextField.isSecureTextEntry = true
            changePasswordEyeBtn.setImage(UIImage(named: "viewHide"), for: UIControl.State())
        }
        passwordEyeClick = !passwordEyeClick
    }
    
    // MARK: - IBActions
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if  nextBtn.backgroundColor == .main {
            if let changePassword = changePwTextField.text {
                changePasswordDataManager.patchChangePassword(ChangePasswordRequest(password: changePassword), delegate: self)
                
                self.navigationController?.popViewController(animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
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
        if passwordTextField.resignFirstResponder() {
            if let nowPassword = passwordTextField.text {
                passwordCheckDataManager.postPasswordCheck(PasswordCheckRequest(password: nowPassword), delegate: self)
            }
        }
        else {
            if let changePassword = changePwTextField.text {
                if passwordTextField.text != changePwTextField.text {
                    changePwLabel.alpha = 1
                    changePwLabel.text = "사용하실 수 있는 비밀번호입니다."
                    changePwLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
                    changePwLabel.textColor = UIColor(red: 72/255, green: 190/255, blue: 0/255, alpha: 1)
                    if passwordLabel.textColor == UIColor(red: 72/255, green: 190/255, blue: 0/255, alpha: 1) {
                        nextBtn.backgroundColor = .main
                    }
                }
                else {
                    changePwLabel.alpha = 1
                    changePwLabel.text = "사용하실 수 없는 비밀번호입니다."
                    changePwLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
                    changePwLabel.textColor = UIColor(red: 241/255, green: 0/255, blue: 0/255, alpha: 1)
                    nextBtn.backgroundColor = .gray03
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        changePwTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

extension ProfilePasswordVC {
    func didSuccessPasswordCheck(result : PasswordCheckData) {
        print("데이터가 성공적으로 들어왔습니다.")
        
        // 현재 비밀번호와 일치할 때
        if result.result ==  true {
            passwordLabel.alpha = 1
            passwordLabel.text = "비밀번호가 일치합니다."
            passwordLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
            passwordLabel.textColor = UIColor(red: 72/255, green: 190/255, blue: 0/255, alpha: 1)
            if changePwLabel.textColor == UIColor(red: 72/255, green: 190/255, blue: 0/255, alpha: 1) {
                nextBtn.backgroundColor = .main
            }
        }
        else {
            passwordLabel.alpha = 1
            passwordLabel.text = "비밀번호가 일치하지 않습니다."
            passwordLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
            passwordLabel.textColor = UIColor(red: 241/255, green: 0/255, blue: 0/255, alpha: 1)
            nextBtn.backgroundColor = .gray03
        }
    }
    
    func didSuccessChangePassword(result : ChangePasswordData) {
        print("데이터가 성공적으로 들어왔습니다.")
    }
    
    func failedToRequest(message : String) {
        print("데이터를 가져오지 못했습니다.")
    }
}

