//
//  LevelModalVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/25.
//

import UIKit

protocol LevelModalDelegate {
    func levelModalDismiss()
    func completeBtnToNextBtn()
}

class LevelModalVC: UIViewController {
    
    var levelModalDelegate : LevelModalDelegate?

    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var lowBtn: UIButton!
    @IBOutlet weak var middleBtn: UIButton!
    @IBOutlet weak var highBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }
    
    func setStyle() {
        
        // titleLabel Style
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.adjusted)
        
        // completeBtn Style
        completeBtn.layer.cornerRadius = 8
        completeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        
        // highStyle
        highBtn.layer.cornerRadius = 8
        highBtn.layer.borderWidth = 1
        highBtn.layer.borderColor = UIColor.gray02.cgColor
        highBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        // middleStyle
        middleBtn.layer.cornerRadius = 8
        middleBtn.layer.borderWidth = 1
        middleBtn.layer.borderColor = UIColor.gray02.cgColor
        middleBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        // lowStyle
        lowBtn.layer.cornerRadius = 8
        lowBtn.layer.borderWidth = 1
        lowBtn.layer.borderColor = UIColor.gray02.cgColor
        lowBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
    }
    
    // cancelBtn
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        levelModalDelegate?.levelModalDismiss()
        dismiss(animated: true, completion: nil)
    }
    
    // completeBtn
    @IBAction func touchUpCompleteBtn(_ sender: Any) {
        levelModalDelegate?.levelModalDismiss()
        levelModalDelegate?.completeBtnToNextBtn()
        dismiss(animated: true, completion: nil)
    }
    
}