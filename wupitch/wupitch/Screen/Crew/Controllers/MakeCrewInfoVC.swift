//
//  MakeCrewInfoVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewInfoVC: UIViewController {

    @IBOutlet var addInfoBtns: [SportsBtn]!
    @IBOutlet var ageBtns: [SportsBtn]!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var crewCountTextField: UITextField!
    @IBOutlet weak var crewNameTextField: UITextField!
    @IBOutlet weak var addSubTitleLabel: LabelFontSize!
    @IBOutlet weak var subTitleLabel: LabelFontSize!
    @IBOutlet weak var addInfoLabel: LabelFontSize!
    @IBOutlet weak var ageLabel: LabelFontSize!
    @IBOutlet weak var crewCountLabel: LabelFontSize!
    @IBOutlet weak var crewNameLabel: LabelFontSize!
    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var makeCrewLabel: LabelFontSize!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: NextBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bgView.endEditing(true)
    }
    
    private func setStyle() {
        // titleLabel Style
        titleLabel.makeCrewTitleLabel()
        // subTitleStyle
        subTitleLabel.makeCrewSubTitleLabel()
        addSubTitleLabel.makeCrewSubTitleLabel()
        
        crewNameTextField.backgroundColor = .gray05
        crewNameTextField.borderStyle = .none
        crewNameTextField.makeRounded(cornerRadius: 8.adjusted)
        crewNameTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        crewNameTextField.textColor = .gray03
        crewNameTextField.addLeftPadding()
        crewNameTextField.delegate = self
        
        crewCountTextField.backgroundColor = .gray05
        crewCountTextField.borderStyle = .none
        crewCountTextField.makeRounded(cornerRadius: 8.adjusted)
        crewCountTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        crewCountTextField.textColor = .gray03
        crewCountTextField.addLeftPadding()
        crewCountTextField.delegate = self
        
        // 추가정보 중복 선택 가능
        for i in 0...7 {
            addInfoBtns[i].graySportsBtn()
        }
    }
    
    func test() {
        if SignUpUserInfo.shared.crewName != nil && SignUpUserInfo.shared.crewCount != nil && SignUpUserInfo.shared.ageBtn != nil {
            nextBtn.backgroundColor = .main
        }
        else {
            nextBtn?.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpFirstBtn(_ sender: Any) {
        if ageBtns[0].status == false {
            ageBtns[0].colorSportsBtn()
            ageBtns[1].defaultSportsBtn()
            ageBtns[2].defaultSportsBtn()
            ageBtns[3].defaultSportsBtn()
            ageBtns[4].defaultSportsBtn()
            SignUpUserInfo.shared.ageBtn = 0
            if SignUpUserInfo.shared.crewName != nil && SignUpUserInfo.shared.crewCount != nil {
                nextBtn.backgroundColor = .main
            }
        }
        else {
            ageBtns[0].defaultSportsBtn()
            SignUpUserInfo.shared.ageBtn = nil
            nextBtn.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpSecondBtn(_ sender: Any) {
        if ageBtns[1].status == false {
            ageBtns[1].colorSportsBtn()
            ageBtns[0].defaultSportsBtn()
            ageBtns[2].defaultSportsBtn()
            ageBtns[3].defaultSportsBtn()
            ageBtns[4].defaultSportsBtn()
            SignUpUserInfo.shared.ageBtn = 1
            if SignUpUserInfo.shared.crewName != nil && SignUpUserInfo.shared.crewCount != nil {
                nextBtn.backgroundColor = .main
            }
            
        }
        else {
            ageBtns[1].defaultSportsBtn()
            SignUpUserInfo.shared.ageBtn = nil
            nextBtn.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpThirdBtn(_ sender: Any) {
        if ageBtns[2].status == false {
            ageBtns[2].colorSportsBtn()
            ageBtns[0].defaultSportsBtn()
            ageBtns[1].defaultSportsBtn()
            ageBtns[3].defaultSportsBtn()
            ageBtns[4].defaultSportsBtn()
            SignUpUserInfo.shared.ageBtn = 2
            if SignUpUserInfo.shared.crewName != nil && SignUpUserInfo.shared.crewCount != nil {
                           nextBtn.backgroundColor = .main
                       }
        }
        else {
            ageBtns[2].defaultSportsBtn()
            SignUpUserInfo.shared.ageBtn = nil
            nextBtn.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpFourthBtn(_ sender: Any) {
        if ageBtns[3].status == false {
            ageBtns[3].colorSportsBtn()
            ageBtns[0].defaultSportsBtn()
            ageBtns[1].defaultSportsBtn()
            ageBtns[2].defaultSportsBtn()
            ageBtns[4].defaultSportsBtn()
            SignUpUserInfo.shared.ageBtn = 3
            if SignUpUserInfo.shared.crewName != nil && SignUpUserInfo.shared.crewCount != nil {
                           nextBtn.backgroundColor = .main
                       }
        }
        else {
            ageBtns[3].defaultSportsBtn()
            SignUpUserInfo.shared.ageBtn = nil
            nextBtn.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpFifthBtn(_ sender: Any) {
        if ageBtns[4].status == false {
            ageBtns[4].colorSportsBtn()
            ageBtns[0].defaultSportsBtn()
            ageBtns[1].defaultSportsBtn()
            ageBtns[2].defaultSportsBtn()
            ageBtns[3].defaultSportsBtn()
            SignUpUserInfo.shared.ageBtn = 4
            if SignUpUserInfo.shared.crewName != nil && SignUpUserInfo.shared.crewCount != nil {
                           nextBtn.backgroundColor = .main
                       }
            
            
        }
        else {
            ageBtns[4].defaultSportsBtn()
            SignUpUserInfo.shared.ageBtn = nil
            nextBtn.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewDate", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewDateVC") as? MakeCrewDateVC {
                navigationController?.pushViewController(dvc, animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension MakeCrewInfoVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        crewNameTextField.textColor = .bk
        crewCountTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if crewNameTextField.text?.isEmpty == false && crewCountTextField.text?.isEmpty == false {
            SignUpUserInfo.shared.crewName = crewNameTextField.text
            SignUpUserInfo.shared.crewCount = crewCountTextField.text
            if SignUpUserInfo.shared.ageBtn != nil {
                nextBtn.backgroundColor = .main
            }
        }
        else {
            SignUpUserInfo.shared.crewName = nil
            SignUpUserInfo.shared.crewCount = nil
            nextBtn.backgroundColor = .gray03
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        crewNameTextField.resignFirstResponder()
        crewCountTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if crewCountTextField.isEditing == true {
            let currentCharacterCount = textField.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            
            return newLength <= 3
        }
        return true
    }
}
