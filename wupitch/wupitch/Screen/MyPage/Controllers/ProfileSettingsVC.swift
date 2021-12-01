//
//  ProfileSettingsVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/25.
//

import UIKit

class ProfileSettingsVC: UIViewController {

    @IBOutlet weak var alertSwitch: UISwitch!
    @IBOutlet var settingsBtn: [UIButton]!
    lazy var withdrawalDataManager = WithdrawalService()
    lazy var toggleAlarmDataManager = ToggleAlarmService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        
        // 회원가입 때 설정했던 알림설정 넣어주기
        alertSwitch.isOn = UserDefaults.standard.bool(forKey: "isPushAgree")
    }
    
    private func setStyle() {
        settingsBtn.forEach {
            $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        }
    }
    
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 스위치 버튼
    @IBAction func touchUpAlertSwitchBtn(_ sender: Any) {
        toggleAlarmDataManager.patchToggleAlarm(delegate: self)
        
        // 데이터가 성공적으로 들어오면 토글 버튼을 유저 디폴트에 저장
        UserDefaults.standard.set(alertSwitch.isOn, forKey: "isPushAgree")
        print("푸시동의알림",UserDefaults.standard.bool(forKey: "isPushAgree"))
    }
    
    // 비밀번호 변경 버튼
    @IBAction func touchUpPasswordBtn(_ sender: Any) {
        //버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "ProfilePassword", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "ProfilePasswordVC") as? ProfilePasswordVC else { return }
        dvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 로그아웃 버튼
    @IBAction func touchUpLogoutBtn(_ sender: Any) {
        // 유저 토큰 삭제
        UserDefaults.standard.removeObject(forKey: "userToken")
            
        let storyboard = UIStoryboard.init(name: "SignIn", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "SignInNC") as? SignInVC else {return}
        print("눌림")
        UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController = dvc
    }
    
    // 회원탈퇴 버튼
    @IBAction func touchUpOutBtn(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "userToken")
        withdrawalDataManager.patchWithdrawal(delegate: self)
    }
}

// 회원 탈퇴 api
// 알림 동의 api
extension ProfileSettingsVC {
    func didSuccessWithdrawal(result: WithdrawalData) {
        print("데이터가 성공적으로 들어왔습니다.")
        print(result.isSuccess)
        
        let storyboard = UIStoryboard.init(name: "SignIn", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "SignInNC") as? SignInVC else {return}

        UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController = dvc

    }
    
    func didSuccessToggleAlarm(result: ToggleAlarmData) {
        print("데이터가 성공적으로 들어왔습니다.")
        print(result.isSuccess)
        
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
        
    }
}


