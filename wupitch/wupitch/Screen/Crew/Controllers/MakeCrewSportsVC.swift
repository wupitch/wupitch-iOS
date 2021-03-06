//
//  CrewMakeCrewVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewSportsVC: UIViewController {
    
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet var sportsBtns: [SportsBtn]!
    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var makeCrewLabel: LabelFontSize!
    
    lazy var sportDataManager = SportsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        sportDataManager.getSports(delegate: self)
    }
    
    private func setStyle() {
        // titleLabel Style
        titleLabel.makeCrewTitleLabel()
    }
    
    // 축구버튼
    @IBAction func touchUpSoccerBtn(_ sender: Any) {
        if sportsBtns[0].status == false {
            sportsBtns[0].colorSportsBtn()
            sportsBtns[1].defaultSportsBtn()
            sportsBtns[2].defaultSportsBtn()
            sportsBtns[3].defaultSportsBtn()
            sportsBtns[4].defaultSportsBtn()
            sportsBtns[5].defaultSportsBtn()
            
            
            nextBtn.colorNextBtnStyle()
        }
        else {
            sportsBtns[0].defaultSportsBtn()
            nextBtn.defaultNextBtnStyle()
        }
    }
    
    @IBAction func touchUpBadmintonBtn(_ sender: Any) {
        if sportsBtns[1].status == false {
            sportsBtns[1].colorSportsBtn()
            sportsBtns[0].defaultSportsBtn()
            sportsBtns[2].defaultSportsBtn()
            sportsBtns[3].defaultSportsBtn()
            sportsBtns[4].defaultSportsBtn()
            sportsBtns[5].defaultSportsBtn()
            nextBtn.colorNextBtnStyle()
        }
        else {
            sportsBtns[1].defaultSportsBtn()
            nextBtn.defaultNextBtnStyle()
        }
    }
    
    @IBAction func touchUpVolleyBallBtn(_ sender: Any) {
        if sportsBtns[2].status == false {
            sportsBtns[2].colorSportsBtn()
            sportsBtns[0].defaultSportsBtn()
            sportsBtns[1].defaultSportsBtn()
            sportsBtns[3].defaultSportsBtn()
            sportsBtns[4].defaultSportsBtn()
            sportsBtns[5].defaultSportsBtn()
            nextBtn.colorNextBtnStyle()
        }
        else {
            sportsBtns[2].defaultSportsBtn()
            nextBtn.defaultNextBtnStyle()
        }
    }
    
    @IBAction func touchUpBasketBallBtn(_ sender: Any) {
        if sportsBtns[3].status == false {
            sportsBtns[3].colorSportsBtn()
            sportsBtns[0].defaultSportsBtn()
            sportsBtns[1].defaultSportsBtn()
            sportsBtns[2].defaultSportsBtn()
            sportsBtns[4].defaultSportsBtn()
            sportsBtns[5].defaultSportsBtn()
            nextBtn.colorNextBtnStyle()
        }
        else {
            sportsBtns[3].defaultSportsBtn()
            nextBtn.defaultNextBtnStyle()
        }
    }
    
    @IBAction func touchUpHikingBtn(_ sender: Any) {
        if sportsBtns[4].status == false {
            sportsBtns[4].colorSportsBtn()
            sportsBtns[0].defaultSportsBtn()
            sportsBtns[1].defaultSportsBtn()
            sportsBtns[2].defaultSportsBtn()
            sportsBtns[3].defaultSportsBtn()
            sportsBtns[5].defaultSportsBtn()
            nextBtn.colorNextBtnStyle()
        }
        else {
            sportsBtns[4].defaultSportsBtn()
            nextBtn.defaultNextBtnStyle()
        }
    }
    
    @IBAction func touchUpRunningBtn(_ sender: Any) {
        if sportsBtns[5].status == false {
            sportsBtns[5].colorSportsBtn()
            sportsBtns[0].defaultSportsBtn()
            sportsBtns[1].defaultSportsBtn()
            sportsBtns[2].defaultSportsBtn()
            sportsBtns[3].defaultSportsBtn()
            sportsBtns[4].defaultSportsBtn()
            nextBtn.colorNextBtnStyle()
        }
        else {
            sportsBtns[5].defaultSportsBtn()
            nextBtn.defaultNextBtnStyle()
        }
    }
    
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            // 어떤 버튼이 눌렸는지 상태 확인
            for i in 0...5 {
                if sportsBtns[i].status == true {
                    // 눌린 버튼 싱글톤에 넣어주기
                    SignUpUserInfo.shared.clickSportsBtn = sportsBtns[i].btnId ?? 0
                    print("현재 눌린 버튼 확인>>>>>>>>>",SignUpUserInfo.shared.clickSportsBtn ?? -99)
                }
            }
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewRegion", bundle: nil)
            guard let dvc = storyBoard.instantiateViewController(identifier: "MakeCrewRegionVC") as? MakeCrewRegionVC else {return}
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension MakeCrewSportsVC {
    func didSuccessSports(result: [SportsResult]) {
        print("값이 성공적으로 들어왔습니다.")
        // 싱글톤 초기화
        SignUpUserInfo.shared.sports = []
        
        for i in 0...5 {
            // 싱글톤에 스포츠 아이디 저장
            SignUpUserInfo.shared.sports?.append(result[i].sportsID)
            // 스포츠 버튼에 아이디값 세팅
            sportsBtns[i].btnId = result[i].sportsID
            print("스포츠이름",result[i].name)
            print("싱글톤에 스포츠 값 잘 들어가나 확인",SignUpUserInfo.shared.sports)
            print("스포츠 버튼 아이디 값", sportsBtns[i].btnId)
        }
    }
    
    func failedToRequest(message: String) {
        print("값이 들어오지 않았습니다.")
    }
}
