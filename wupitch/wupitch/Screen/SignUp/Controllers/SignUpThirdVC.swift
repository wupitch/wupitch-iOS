//
//  SignUpThirdVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

class SignUpThirdVC: UIViewController {

    @IBOutlet weak var textView: UIView!
    @IBOutlet var sportBtns: [UIButton]!
    @IBOutlet weak var etcTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var textCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        
    }
    
    func setStyle() {
        
        etcTextField.alpha = 0.0
        textCount.alpha = 0.0
        textView.alpha = 0.0
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.tintColor = .bk
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 20.adjusted)
        
        sportBtns[0].layer.cornerRadius = 8
        sportBtns[0].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        sportBtns[1].layer.cornerRadius = 8
        sportBtns[1].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        sportBtns[2].layer.cornerRadius = 8
        sportBtns[2].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        sportBtns[3].layer.cornerRadius = 8
        sportBtns[3].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        sportBtns[4].layer.cornerRadius = 8
        sportBtns[4].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        nextBtn.layer.cornerRadius = 8
        nextBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        
        etcTextField.attributedPlaceholder = NSAttributedString(string: "기타 스포츠를 입력해주세요. (선택)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray03])
        
        textCount.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
    }
    
    @IBAction func etcBtn(_ sender: Any) {
        etcTextField.alpha = 1
        textCount.alpha = 1
        textView.alpha = 1
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "SignUpFourth", bundle: nil)
                
                guard let dvc = storyboard.instantiateViewController(identifier: "SignUpFourthVC") as? SignUpFourthVC else {return}
                
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}
