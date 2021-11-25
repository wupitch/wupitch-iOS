//
//  ProfileVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit

class ProfileVC: BaseVC {

    @IBOutlet weak var myPageLabel: LabelFontSize!
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var profileBgView: UIView!
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var nicknameLabel: LabelFontSize!
    @IBOutlet weak var subLabel: LabelFontSize!
    @IBOutlet weak var profileSettingBtn: UIButton!
    @IBOutlet weak var profileAlertLabel: UILabel!
    @IBOutlet var settingsBtn: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    private func setStyle() {
        settingsBtn.forEach {
            $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        }
        myPageLabel.titleLabelFontSize()
        profileBgView.makeRounded(cornerRadius: 16)
        profileBgView.layer.borderWidth = 1
        profileBgView.layer.borderColor = UIColor.gray04.cgColor
        nicknameLabel.nicknameLabelFontSize()
        subLabel.CrewNoPlaceLabel()
        profileAlertLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        profileAlertLabel.setTextWithLineHeight(text: profileAlertLabel.text, lineHeight: 20)
        
    }
    
    // 알림 버튼
    @IBAction func touchUpAlertBtn(_ sender: Any) {
        
    }
    
    // 카메라 버튼
    @IBAction func touchUpCameraBtn(_ sender: Any) {
    }
    
    // 화살표 버튼
    @IBAction func touchUpArrowBtn(_ sender: Any) {
        
        //버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "ProfileDetail", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "ProfileDetailVC") as? ProfileDetailVC else {return}
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }
    
    
}
