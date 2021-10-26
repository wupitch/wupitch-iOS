//
//  SignUpCompleteFirstVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/27.
//

import UIKit

class SignUpCompleteFirstVC: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
       
    }
    
    func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20.adjusted)
        titleLabel.textColor = .bk
        
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 22.adjusted)
        descriptionLabel.textColor = .gray02
        
        startBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        startBtn.layer.cornerRadius = 8
    }
    


}
