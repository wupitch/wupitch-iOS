//
//  SignUpPhoneVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class SignUpPhoneVC: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    lazy var memberPhoneNumber = MemberPhoneNumberService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        memberPhoneNumber.getMemberPhoneNumber(delegate: self)
    }
    
    private func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 35.adjusted)
    }
  
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }
    
    // 완료 버튼
    @IBAction func touchUpCompleteBtn(_ sender: Any) {
        
    }
    
    
}

extension SignUpPhoneVC {
    func didSuccessMemberPhoneNumber(result: MemberPhoneNumberResult) {
        print("데이터가 성공적으로 들어왔습니다.")
        
        if result.phoneNumber != nil {
            phoneTextField.text = result.phoneNumber
        }
        else {
            print("값이 없어요")
        }
        
    }
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}

