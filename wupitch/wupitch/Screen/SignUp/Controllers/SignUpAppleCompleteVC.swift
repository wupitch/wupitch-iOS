//
//  SignUpSixthVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

class SignUpAppleCompleteVC: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        print("<<<<<<<<<<<<<싱글톤데이터잘들어가있나확인>>>>>>>>>>>>>>>")
        print("사진", SignUpUserInfo.shared.idImg ?? "값없어")
    }
    
    func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        titleLabel.textColor = .bk
        
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 22.adjusted)
        descriptionLabel.textColor = .gray02
        
        startBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        startBtn.makeRounded(cornerRadius: 8.adjusted)
    }
    
    @IBAction func touchUpCompleteBtn(_ sender: Any) {
        
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 OnbordingVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let onboardingVC = viewController as? OnbordingVC { self.navigationController?.popToViewController(onboardingVC, animated: true)
                print("닉네임 있어?",SignUpUserInfo.shared.nickName ?? "값이 없습니다.")
            }
        }
    }
    
}


