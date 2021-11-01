//
//  UserInfoWarningVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/01.
//

import UIKit

class UserInfoWarningVC: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var contentSubLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }
    
    
       func setStyle() {
           alertView.layer.cornerRadius = 16.adjusted
           contentLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
           contentLabel.setTextWithLineHeight(text: contentLabel.text, lineHeight: 24.adjusted)
           contentLabel.textAlignment = .center
           completeBtn.backgroundColor = .main
           completeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
           completeBtn.tintColor = .wht
           completeBtn.layer.cornerRadius = 8.adjusted
           
           contentSubLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
           contentSubLabel.textColor = .bk
           contentSubLabel.setTextWithLineHeight(text: contentSubLabel.text, lineHeight: 24.adjusted)
           contentSubLabel.textAlignment = .center
       }


}
