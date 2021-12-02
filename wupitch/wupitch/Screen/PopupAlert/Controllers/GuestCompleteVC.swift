//
//  GuestCompleteVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit

class GuestCompleteVC: UIViewController {

    @IBOutlet weak var contentSubLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    
    var firstLabel: String?
    var secondLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let first = firstLabel {
            self.contentLabel.text = first
        }
        if let second = secondLabel {
            self.contentSubLabel.text = second
        }
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
        
        contentSubLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        contentSubLabel.textColor = .gray02
        //contentSubLabel.setTextWithLineHeight(text: contentSubLabel.text, lineHeight: 20.adjusted)
    }

    @IBAction func touchUpCompleteBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
