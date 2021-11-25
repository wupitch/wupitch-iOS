//
//  SignUpPhoneVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class SignUpPhoneVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    private func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 35.adjusted)
    }
  
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }
    
    // 완료 버튼
    @IBAction func touchUpCompleteBtn(_ sender: Any) {
        
    }
    
    
}
