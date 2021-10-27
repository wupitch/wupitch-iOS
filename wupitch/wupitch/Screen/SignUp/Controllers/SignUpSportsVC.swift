//
//  SignUpThirdVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

class SignUpSportsVC: UIViewController {
    
    @IBOutlet weak var modalBgView: UIView!
//    @IBOutlet weak var textView: UIView!
//    @IBOutlet var sportBtns: [UIButton]!
//    @IBOutlet weak var etcTextField: UITextField!
//    @IBOutlet weak var nextBtn: UIButton!
//    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var cancelBtn: UIButton!
//    @IBOutlet weak var backBtn: UIButton!
//    @IBOutlet weak var textCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //etcTextField.delegate = self
        //setStyle()
        modalBgView.alpha = 0.0
        
    }
    
//    func setStyle() {
//
//        etcTextField.alpha = 0.0
//        textCount.alpha = 0.0
//        textView.alpha = 0.0
//
//        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
//        titleLabel.tintColor = .bk
//        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
//
//        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
//        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 20.adjusted)
//
//        sportBtns[0].layer.cornerRadius = 8
//        sportBtns[0].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
//
//        sportBtns[1].layer.cornerRadius = 8
//        sportBtns[1].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
//
//        sportBtns[2].layer.cornerRadius = 8
//        sportBtns[2].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
//
//        sportBtns[3].layer.cornerRadius = 8
//        sportBtns[3].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
//
//        sportBtns[4].layer.cornerRadius = 8
//        sportBtns[4].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
//
//        sportBtns[5].layer.cornerRadius = 8
//        sportBtns[5].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
//
//        sportBtns[6].layer.cornerRadius = 8
//        sportBtns[6].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
//
//        nextBtn.layer.cornerRadius = 8
//        nextBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
//
//        etcTextField.attributedPlaceholder = NSAttributedString(string: "기타 스포츠를 입력해주세요. (선택)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray03])
//
//        textCount.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
//    }
//
//
//
//    @IBAction func touchUpBackBtn(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//    }
//
//    @IBAction func touchUpCancelBtn(_ sender: Any) {
//        // 취소 버튼 클릭 시, 팝업 창 띄워줌
//        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
//
//        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
//            dvc.modalPresentationStyle = .overFullScreen
//            dvc.modalTransitionStyle = .crossDissolve
//
//            // present 형태로 띄우기
//            self.present(dvc, animated: true, completion: nil)
//        }
//    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        
     
            let storyboard = UIStoryboard.init(name: "SignUpAge", bundle: nil)
            
            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpAgeVC") as? SignUpAgeVC else {return}
            
            self.navigationController?.pushViewController(dvc, animated: true)
        }

    
//    @IBAction func touchUpSoccerBtn(_ sender: UIButton) {
//
//        sportBtns[0].backgroundColor = .main20
//        sportBtns[0].layer.borderWidth = 1
//        sportBtns[0].layer.borderColor = UIColor.main.cgColor
//        sportBtns[0].tintColor = .main
//
//        let storyBoard: UIStoryboard = UIStoryboard(name: "LevelModal", bundle: nil)
//        if let dvc = storyBoard.instantiateViewController(withIdentifier: "LevelModalVC") as? LevelModalVC {
//            dvc.modalPresentationStyle = .overFullScreen
//
//            modalBgView.alpha = 1
//            dvc.levelModalDelegate = self
//
//            self.present(dvc, animated: true, completion: nil)
//
//        }
//    }
//
//    @IBAction func touchUpBadmintonBtn(_ sender: UIButton) {
//        if sender.isSelected == false {
//            sender.isSelected = true
//            sportBtns[1].backgroundColor = .main20
//            sportBtns[1].tintColor = .main
//
//            let storyBoard: UIStoryboard = UIStoryboard(name: "LevelModal", bundle: nil)
//            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LevelModalVC") as? LevelModalVC {
//                dvc.modalPresentationStyle = .overFullScreen
//
//                modalBgView.alpha = 1
//                dvc.levelModalDelegate = self
//
//                self.present(dvc, animated: true, completion: nil)
//            }
//
//        }
//        else {
//            sender.isSelected = false
//            sportBtns[1].backgroundColor = .gray04
//            sportBtns[1].tintColor = .gray02
//        }
//    }
//
//
//    @IBAction func touchUpVolleyBallBtn(_ sender: UIButton) {
//        if sender.isSelected == false {
//            sender.isSelected = true
//            sportBtns[2].backgroundColor = .main20
//            sportBtns[2].tintColor = .main
//
//            let storyBoard: UIStoryboard = UIStoryboard(name: "LevelModal", bundle: nil)
//            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LevelModalVC") as? LevelModalVC {
//                dvc.modalPresentationStyle = .overFullScreen
//
//                modalBgView.alpha = 1
//                dvc.levelModalDelegate = self
//
//                self.present(dvc, animated: true, completion: nil)
//            }
//
//        }
//        else {
//            sender.isSelected = false
//            sportBtns[2].backgroundColor = .gray04
//            sportBtns[2].tintColor = .gray02
//        }
//    }
//
//    @IBAction func touchUpBaseballBtn(_ sender: UIButton) {
//        if sender.isSelected == false {
//            sender.isSelected = true
//            sportBtns[3].backgroundColor = .main20
//            sportBtns[3].tintColor = .main
//
//            let storyBoard: UIStoryboard = UIStoryboard(name: "LevelModal", bundle: nil)
//            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LevelModalVC") as? LevelModalVC {
//                dvc.modalPresentationStyle = .overFullScreen
//
//                modalBgView.alpha = 1
//                dvc.levelModalDelegate = self
//
//                self.present(dvc, animated: true, completion: nil)
//            }
//
//        }
//        else {
//            sender.isSelected = false
//            sportBtns[3].backgroundColor = .gray04
//            sportBtns[3].tintColor = .gray02
//        }
//    }
//
//    @IBAction func etcBtn(_ sender: UIButton) {
//        if sender.isSelected == false {
//            sender.isSelected = true
//            sportBtns[4].backgroundColor = .main20
//            sportBtns[4].tintColor = .main
//            etcTextField.alpha = 1
//            textCount.alpha = 1
//            textView.alpha = 1
//        }
//        else {
//            sender.isSelected = false
//            sportBtns[4].backgroundColor = .gray04
//            sportBtns[4].tintColor = .gray02
//            etcTextField.alpha = 0.0
//            textCount.alpha = 0.0
//            textView.alpha = 0.0
//        }
//    }


}

//extension SignUpSportsVC: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // backspace 감지하기
//        if let char = string.cString(using: String.Encoding.utf8) {
//            let isBackSpace = strcmp(char, "\\b")
//            if isBackSpace == -92 {
//                return true
//            }
//        }
//        // 글자수제한
//        guard textField.text!.count < 20
//
//        else {
//            return false
//        }
//        textCount.text = "\(textField.text?.count)" + "/20"
//
//        return true
//    }
//}

//extension SignUpSportsVC: LevelModalDelegate {
//    func levelModalDismiss() {
//        modalBgView.alpha = 0.0
//        sportBtns[0].backgroundColor = .gray04
//        sportBtns[0].tintColor = .gray02
//        sportBtns[0].layer.borderWidth = 0
//
//    }
//
//    func completeBtnToNextBtn() {
//        nextBtn.backgroundColor = .main
//        sportBtns[0].backgroundColor = .main20
//        sportBtns[0].layer.borderWidth = 1
//        sportBtns[0].layer.borderColor = UIColor.main.cgColor
//        sportBtns[0].tintColor = .main
//    }
//
//
//}

