//
//  SignUpPhoneVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class SignUpPhoneVC: UIViewController {

    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    lazy var memberPhoneNumber = MemberPhoneNumberService()
    lazy var phoneNumberInformationDataManager = PhoneNumberInformationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        addDoneButtonOnKeyboard()
        memberPhoneNumber.getMemberPhoneNumber(delegate: self)
    }
    
    private func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 35.adjusted)
        
        phoneTextField.delegate = self
        phoneTextField.backgroundColor = .gray05
        phoneTextField.borderStyle = .none
        phoneTextField.makeRounded(cornerRadius: 8.adjusted)
        phoneTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        phoneTextField.textColor = .gray03
        phoneTextField.addLeftPadding()
    }
    
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

        phoneTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            phoneTextField.resignFirstResponder()
        }
  
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // 완료 버튼
    @IBAction func touchUpCompleteBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
        phoneNumberInformationDataManager.patchInformation(PhoneNumberRequest(phoneNumber: phoneTextField.text ?? ""), delegate: self)
            
            navigationController?.popViewController(animated: true)
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension SignUpPhoneVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        phoneTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if phoneTextField.text?.isEmpty == false {
            nextBtn.backgroundColor = .main
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if phoneTextField.isEditing == true {
            let currentCharacterCount = textField.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            
            return newLength <= 11
        }
        return true
    }
}

extension SignUpPhoneVC {
    func didSuccessMemberPhoneNumber(result: MemberPhoneNumberResult) {
        print("데이터가 성공적으로 들어왔습니다.")
        
        if result.phoneNumber != nil {
            phoneTextField.text = result.phoneNumber
            phoneTextField.textColor = .bk
            UserDefaults.standard.set(result.phoneNumber, forKey: "pagePhone")
        }
        else {
            print("값이 없어요")
        }
    }
    
    // 회원 수정 에이피아이
    func didSuccessInformation(result: InformationData) {
        print("수정한 값이 성공적으로 적용되었습니다.")
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}

