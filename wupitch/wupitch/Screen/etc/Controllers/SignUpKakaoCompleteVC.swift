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
    
    //lazy var informationDataManager = InformationService()
    
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
        //titleLabel.text = (SignUpUserInfo.shared.nickName ?? "닉네임없음") + " 님, 환영합니다"
    }
    
    // 홈으로 이동
    @IBAction func touchUpStartBtn(_ sender: Any) {
        // 홈 스토리 보드로 이동할 경로
        let storyboard = UIStoryboard.init(name: "Tabbar", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "TabbarVC") as? TabbarVC else {return}
        
//        var ageNum = SignUpUserInfo.shared.age ?? -1
//        var areaId = SignUpUserInfo.shared.region ?? "값없음"
//        var introduce = SignUpUserInfo.shared.userIntroduce ?? "값없음"
//        var nickname = SignUpUserInfo.shared.nickName ?? "값없음"
//        var otherSports = SignUpUserInfo.shared.etcText ?? "값없음"
//        var sportsList = SignUpUserInfo.shared.sportsList
//
//        informationDataManager.patchInformation(InformationRequest(ageNum: ageNum areaId: areaId, introduce: introduce, nickname: nickname, otherSports: otherSports, sportsList: sportsList), delegate: self)
        
        // navigation push로 이동
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

// information 한번에 받는 api
//extension SignUpKakaoCompleteVC {
//    func didSuccessInformation(result: InformationData) {
//        print("데이터가 성공적으로 들어왔습니다.")
//
//    }
//    func failedToRequest(message: String) {
//        print("데이터가 들어오지 않았습니다.")
//
//    }
//}
