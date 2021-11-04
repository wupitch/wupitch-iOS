//
//  SignUpCompleteFirstVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/27.
//

import UIKit

class SignUpKakaoCompleteVC: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        changeTitleLabelToNickname()
    }
    
    func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20.adjusted)
        titleLabel.textColor = .bk
        
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 22.adjusted)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .gray02
        
        startBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        startBtn.backgroundColor = .main
        startBtn.titleLabel?.textColor = .wht
        startBtn.makeRounded(cornerRadius: 8.adjusted)
    }
    
    func changeTitleLabelToNickname() {
        titleLabel.text = (SignUpUserInfo.shared.nickName ?? "닉네임없음") + " 님, 환영합니다"
    }
    
    // 홈으로 이동
    @IBAction func touchUpStartBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Tabbar", bundle: nil)
        
        guard let dvc = storyboard.instantiateViewController(identifier: "TabbarVC") as? TabbarVC else {return}
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}
