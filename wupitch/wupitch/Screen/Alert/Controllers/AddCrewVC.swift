//
//  AddCrewVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit

class AddCrewVC: UIViewController {

    @IBOutlet weak var wupitchEmailLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet var contentLabel: [UILabel]!
    @IBOutlet var borderView: [UIView]!
    @IBOutlet weak var popUpBgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var contentLabelCount = [1,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }
    
    private func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        titleLabel.textColor = .bk
        
        wupitchEmailLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        wupitchEmailLabel.textColor = .gray02
        
        registerBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        registerBtn.tintColor = .wht
        registerBtn.backgroundColor = .main
        registerBtn.layer.cornerRadius = 8.adjusted
        
        popUpBgView.layer.cornerRadius = 16.adjusted
        
        contentLabel[0].font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        contentLabel[0].setTextWithLineHeight(text: contentLabel[0].text, lineHeight: 22.adjusted)
        contentLabel[0].textAlignment = .center
        contentLabel[0].textColor = .bk
        
        contentLabel[1].font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13.adjusted)
        contentLabel[1].setTextWithLineHeight(text: contentLabel[1].text, lineHeight: 22.adjusted)
        contentLabel[1].textAlignment = .center
        contentLabel[1].textColor = .bk
        
        contentLabel[2].font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        contentLabel[2].setTextWithLineHeight(text: contentLabel[2].text, lineHeight: 22.adjusted)
        contentLabel[2].textAlignment = .center
        contentLabel[2].textColor = .bk
        
        borderView[0].layer.borderWidth = 1.adjusted
        borderView[0].layer.cornerRadius = 8.adjusted
        borderView[0].layer.borderColor = UIColor.main.cgColor
        
        borderView[1].layer.borderWidth = 1.adjusted
        borderView[1].layer.cornerRadius = 8.adjusted
        borderView[1].layer.borderColor = UIColor.main.cgColor
        
        borderView[2].layer.borderWidth = 1.adjusted
        borderView[2].layer.cornerRadius = 8.adjusted
        borderView[2].layer.borderColor = UIColor.main.cgColor
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
    }
    
    @IBAction func touchUpRegisterBtn(_ sender: Any) {
    }
    

}
