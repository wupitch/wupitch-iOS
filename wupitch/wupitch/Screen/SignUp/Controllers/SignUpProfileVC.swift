//
//  SignUpFourthVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

class SignUpProfileVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var textCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        placeholderSetting()
    }
    
    func placeholderSetting() {
        infoTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        infoTextView.text = "자기소개를 입력해주세요."
        infoTextView.textColor = .gray02
    }
    
    
    func setStyle() {
        
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
        infoTextView.layer.cornerRadius = 8
        infoTextView.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        infoTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        // textcountLabel Style
        textCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        
        // startBtn Style
        startBtn.layer.cornerRadius = 8
        startBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        
        
    }
    
    // backBtn
    @IBAction func touchUpBackBtn(_ sender: Any) {
        print("뒤로가기")
        navigationController?.popViewController(animated: true)
    }
    
    // cancelBtn
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        // 취소 버튼 클릭 시, 팝업 창 띄워줌
        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
        
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
            dvc.modalPresentationStyle = .overFullScreen
            dvc.modalTransitionStyle = .crossDissolve
            
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    // startBtn
    @IBAction func touchUpStartBtn(_ sender: Any) {
        
    }
    
    
}

extension SignUpProfileVC: UITextViewDelegate {
    
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if infoTextView.textColor == .gray02 {
            infoTextView.text = nil
            infoTextView.textColor = .gray02
        }
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if infoTextView.text.isEmpty {
            infoTextView.text = "자기소개를 입력해주세요."
            infoTextView.textColor = .gray02
        }
    }
}



