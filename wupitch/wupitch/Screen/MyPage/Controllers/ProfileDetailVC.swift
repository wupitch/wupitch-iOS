//
//  ProfileDetailVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/25.
//

import UIKit

class ProfileDetailVC: UIViewController {

    @IBOutlet var profileBtns: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    private func setStyle() {
        profileBtns.forEach {
            $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        }
    }
  
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 닉네임 및 소개 버튼
    @IBAction func touchUpNicknameBtn(_ sender: Any) {
        
        //버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "ProfileNickname", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "ProfileNicknameVC") as? ProfileNicknameVC else {return}
        dvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 지역 버튼
    @IBAction func touchUpRegionBtn(_ sender: Any) {
        
        //버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "SignUpCity", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpCityVC") as? SignUpCityVC else {return}
        dvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 관심 스포츠 버튼
    @IBAction func touchUpSportsBtn(_ sender: Any) {
        
        //버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "SignUpSports", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpSportsVC") as? SignUpSportsVC else {return}
        dvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 연령대 버튼
    @IBAction func touchUpAgeBtn(_ sender: Any) {
        
        //버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "SignUpAge", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpAgeVC") as? SignUpAgeVC else {return}
        dvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 연락처 버튼
    @IBAction func touchUpNumberBtn(_ sender: Any) {
        
        //버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "SignUpPhone", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpPhoneVC") as? SignUpPhoneVC else {return}
        dvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}
