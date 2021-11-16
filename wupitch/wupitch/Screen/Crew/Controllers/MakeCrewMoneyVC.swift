//
//  MakeCrewMoneyVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewMoneyVC: UIViewController {
    @IBOutlet weak var noMoneyLabel: CheckBtn!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var titleLabel: LabelFontSize!
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        addDoneButtonOnKeyboard()
    }

    private func setStyle() {
        titleLabel.makeCrewTitleLabel()
        titleTextField.delegate = self
        titleTextField.backgroundColor = .gray05
        titleTextField.borderStyle = .none
        titleTextField.makeRounded(cornerRadius: 8.adjusted)
        titleTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        titleTextField.textColor = .gray03
        titleTextField.addLeftPadding()
        
        noMoneyLabel.setTitleColor(.gray02, for: .normal)
        noMoneyLabel.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        noMoneyLabel.titleLabel?.setTextWithLineHeight(text: noMoneyLabel.titleLabel?.text, lineHeight: 19.adjusted)
        
        noMoneyLabel.grayCheck()
    }
    
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

        titleTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            titleTextField.resignFirstResponder()
        }
    
    
    @IBAction func touchUpNoMoneyBtn(_ sender: Any) {
        if noMoneyLabel.status == false {
            noMoneyLabel.colorCheck()
            titleTextField.isEnabled = false
            titleTextField.text = nil
            nextBtn.backgroundColor = .main
        }
        else {
            noMoneyLabel.grayCheck()
            titleTextField.isEnabled = true
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
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewGuest", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewGuestVC") as? MakeCrewGuestVC {
                navigationController?.pushViewController(dvc, animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }

}

extension MakeCrewMoneyVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if titleTextField.text?.isEmpty == false {
            nextBtn.backgroundColor = .main
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 6자리로 막아놓기
        if titleTextField.isEditing == true {
            let currentCharacterCount = textField.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            
            return newLength <= 6
        }
        return true
    }
        
// 텍스트필드 값 쉼표구분
//        // replacementString : 방금 입력된 문자 하나, 붙여넣기 시에는 붙여넣어진 문자열 전체
//        // return -> 텍스트가 바뀌어야 한다면 true, 아니라면 false
//        // 이 메소드 내에서 textField.text는 현재 입력된 string이 붙기 전의 string
//
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal // 1,000,000
//        formatter.locale = Locale.current
//        formatter.maximumFractionDigits = 0 // 허용하는 소숫점 자리수
//
//        // formatter.groupingSeparator // .decimal -> ,
//
//        if let removeAllSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){
//
//
//            var beforeForemattedString = removeAllSeprator + string
//            if formatter.number(from: string) != nil {
//                if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
//                    textField.text = formattedString
//
//                    return false
//                }
//
//            }else{ // 숫자가 아닐 때먽
//                if string == "" { // 백스페이스일때
//                    let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
//                    beforeForemattedString = String(beforeForemattedString[..<lastIndex])
//                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
//                        textField.text = formattedString
//                        return false
//                    }
//                }else{ // 문자일 때
//                    return false
//                }
//            }
//        }
//        return true
//    }
}
