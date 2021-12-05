//
//  SignUpSixthVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

class SignUpCompleteVC : UIViewController {

    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    func setStyle() {
        nextBtn.backgroundColor = .main
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        titleLabel.textColor = .bk
        
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 22.adjusted)
        descriptionLabel.textColor = .gray02
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 SignInVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let signInVC = viewController as? SignInVC { self.navigationController?.popToViewController(signInVC, animated: true)
            }
        }
    }
}


