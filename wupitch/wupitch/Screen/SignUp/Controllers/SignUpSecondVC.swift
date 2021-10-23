//
//  SignUpSecondVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/18.
//

import UIKit

class SignUpSecondVC: UIViewController, SignUpPickerDelegate {
    
    @IBOutlet weak var modalBgView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var selectTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        modalBgView.alpha = 0.0
        selectTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
        
    }
    func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.tintColor = .bk
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        
        selectTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        //selectTextField.textColor = .gray02
        selectTextField.attributedPlaceholder = NSAttributedString(string: "지역구 선택", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        selectTextField.layer.borderColor = UIColor.gray02.cgColor
        selectTextField.layer.borderWidth = 1
        selectTextField.layer.cornerRadius = 8
        
        nextBtn.layer.cornerRadius = 8
        nextBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
    }
    
    func modalViewDismiss() {
        modalBgView.alpha = 0.0
        
    }
    
    func textFieldData() {
        selectTextField.text = locationPickerData[0].locationName
        selectTextField.text = locationPickerData[1].locationName
        selectTextField.text = locationPickerData[2].locationName
        selectTextField.text = locationPickerData[3].locationName
        
    }
    
        @objc func textFieldDidChange(_ textField:UITextField) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "LocationPicker", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "LocationPickerVC") as? LocationPickerVC {
                dvc.modalPresentationStyle = .overFullScreen
    
                modalBgView.alpha = 1
    
                self.present(dvc, animated: true, completion: nil)
            }
    
        }
    
    
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "SignUpThird", bundle: nil)
        
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpThirdVC") as? SignUpThirdVC else {return}
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
}


