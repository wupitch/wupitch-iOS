//
//  SignUpAgeVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/27.
//

import UIKit

class SignUpAgeVC: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet var ageBtns: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }
    
    func setStyle() {
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        
        ageBtns[0].layer.cornerRadius = 8.adjusted
        ageBtns[0].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)

        ageBtns[1].layer.cornerRadius = 8.adjusted
        ageBtns[1].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)


        ageBtns[2].layer.cornerRadius = 8.adjusted
        ageBtns[2].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)

        ageBtns[3].layer.cornerRadius = 8.adjusted
        ageBtns[3].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)

        ageBtns[4].layer.cornerRadius = 8.adjusted
        ageBtns[4].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        nextBtn.layer.cornerRadius = 8.adjusted
        nextBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
    }
}
