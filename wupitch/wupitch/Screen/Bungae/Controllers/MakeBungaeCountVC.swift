//
//  MakeBungaeCountVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/23.
//

import UIKit

class MakeBungaeCountVC: UIViewController {

    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countTextField.backgroundColor = .gray05
        countTextField.borderStyle = .none
        countTextField.makeRounded(cornerRadius: 8.adjusted)
        countTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        countTextField.textColor = .gray03
        countTextField.addLeftPadding()
        countTextField.delegate = self
        
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

        countTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            countTextField.resignFirstResponder()
        }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            SignUpUserInfo.shared.bungaeCount = Int(countTextField.text ?? "") ?? nil
            print("모집인원 >>>>>>>>>>>>>>>", SignUpUserInfo.shared.bungaeCount)
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeBungaeMoney", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeBungaeMoneyVC") as? MakeBungaeMoneyVC {
                navigationController?.pushViewController(dvc, animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension MakeBungaeCountVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        countTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if countTextField.text?.isEmpty == false {
            nextBtn.backgroundColor = .main
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        countTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 2자리로 막아놓기
        if countTextField.isEditing == true {
            let currentCharacterCount = textField.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            
            return newLength <= 2
        }
        return true
    }
}
