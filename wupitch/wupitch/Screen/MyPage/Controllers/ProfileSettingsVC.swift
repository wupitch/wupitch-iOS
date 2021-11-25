//
//  ProfileSettingsVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/25.
//

import UIKit

class ProfileSettingsVC: UIViewController {

    @IBOutlet var settingsBtn: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    private func setStyle() {
        settingsBtn.forEach {
            $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        }
    }
    
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    // 스위치 버튼
    @IBAction func touchUpAlertSwitchBtn(_ sender: Any) {
        
    }
    
    // 비밀번호 변경 버튼
    @IBAction func touchUpPasswordBtn(_ sender: Any) {
        //버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "ProfilePassword", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "ProfilePasswordVC") as? ProfilePasswordVC else {return}
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 로그아웃 버튼
    @IBAction func touchUpLogoutBtn(_ sender: Any) {
        // 유저 토큰 삭제
        UserDefaults.standard.removeObject(forKey: "userToken")
       
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 SignInVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let signInVC = viewController as? SignInVC { self.navigationController?.popToViewController(signInVC, animated: true)
            }
        }
    }
    
    // 회원탈퇴 버튼
    @IBAction func touchUpOutBtn(_ sender: Any) {
    }
    
    
}
