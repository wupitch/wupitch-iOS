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

extension MakeCrewMoneyVC: UITextViewDelegate, UITextFieldDelegate {
    
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
    
}
