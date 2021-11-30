//
//  CrewFilterVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import UIKit
import Alamofire

// 크루 필터 VC
class CrewFilterVC: BaseVC {
    
    @IBOutlet weak var toastMessageLabel: UILabel!
    @IBOutlet weak var toastView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: LabelFontSize!
    
    @IBOutlet weak var sportsLabel: LabelFontSize!
    @IBOutlet var sportsBtns: [SportsBtn]!
    
    @IBOutlet weak var dateLabel: LabelFontSize!
    @IBOutlet var dateBtns: [SportsBtn]!
    
    @IBOutlet weak var crewCountLabel: LabelFontSize!
    @IBOutlet var crewCountBtns: [SportsBtn]!
    
    @IBOutlet weak var ageLabel: LabelFontSize!
    @IBOutlet var ageBtns: [SportsBtn]!
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var applyBtn: NextBtn!
    
    var dict = [String:[Any]]()
    
    lazy var crewFilterDataMangaer = LookUpCrewFiletrService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        crewFilterDataMangaer.getLookUpCrewFilter(delegate: self)
    }

    private func setStyle() {
        
        // applyBtn default
        applyBtn.colorNextBtnStyle()
        
        // resetBtn
        resetBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        resetBtn.tintColor = .gray02
        
        toastView.alpha = 0.0
        toastView.makeRounded(cornerRadius: 16.adjusted)
        toastMessageLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        // 종목, 연령대 중복 선택 가능
        for i in 0...5 {
            sportsBtns[i].graySportsBtn()
            ageBtns[i].graySportsBtn()
        }
        // 요일 중복 선택 가능
        for j in 0...6 {
            dateBtns[j].graySportsBtn()
        }
    }
    
    @IBAction func touchUpCrewCountFirst(_ sender: Any) {
        if crewCountBtns[0].status == false {
            crewCountBtns[0].colorSportsBtn()
            crewCountBtns[1].defaultSportsBtn()
            crewCountBtns[2].defaultSportsBtn()
            crewCountBtns[3].defaultSportsBtn()
            crewCountBtns[4].defaultSportsBtn()
        }
        else {
            crewCountBtns[0].defaultSportsBtn()
        }
    }
    @IBAction func touchUpCrewCountSecond(_ sender: Any) {
        if crewCountBtns[1].status == false {
            crewCountBtns[1].colorSportsBtn()
            crewCountBtns[0].defaultSportsBtn()
            crewCountBtns[2].defaultSportsBtn()
            crewCountBtns[3].defaultSportsBtn()
            crewCountBtns[4].defaultSportsBtn()
        }
        else {
            crewCountBtns[1].defaultSportsBtn()
        }
    }
    @IBAction func touchUpCrewCountThird(_ sender: Any) {
        if crewCountBtns[2].status == false {
            crewCountBtns[2].colorSportsBtn()
            crewCountBtns[0].defaultSportsBtn()
            crewCountBtns[1].defaultSportsBtn()
            crewCountBtns[3].defaultSportsBtn()
            crewCountBtns[4].defaultSportsBtn()
        }
        else {
            crewCountBtns[2].defaultSportsBtn()
        }
    }
    @IBAction func touchUpCrewCountFourth(_ sender: Any) {
        if crewCountBtns[3].status == false {
            crewCountBtns[3].colorSportsBtn()
            crewCountBtns[0].defaultSportsBtn()
            crewCountBtns[1].defaultSportsBtn()
            crewCountBtns[2].defaultSportsBtn()
            crewCountBtns[4].defaultSportsBtn()
        }
        else {
            crewCountBtns[3].defaultSportsBtn()
        }
    }
    @IBAction func touchUpCrewCountFifth(_ sender: Any) {
        if crewCountBtns[4].status == false {
            crewCountBtns[4].colorSportsBtn()
            crewCountBtns[0].defaultSportsBtn()
            crewCountBtns[1].defaultSportsBtn()
            crewCountBtns[2].defaultSportsBtn()
            crewCountBtns[3].defaultSportsBtn()
        }
        else {
            crewCountBtns[4].defaultSportsBtn()
        }
    }
    
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // 초기화 버튼
    @IBAction func touchUpResetBtn(_ sender: Any) {
        for i in 0...5 {
            if sportsBtns[i].status == true || ageBtns[i].status == true {
                sportsBtns[i].defaultSportsBtn()
                ageBtns[i].defaultSportsBtn()
            }
        }
        for i in 0...6 {
            if dateBtns[i].status == true {
                dateBtns[i].defaultSportsBtn()
            }
        }
        for i in 0...4 {
            if crewCountBtns[i].status == true {
                crewCountBtns[i].defaultSportsBtn()
            }
        }
        dict = [String:[Any]]()
        print("초기화")
    }
    
    @IBAction func touchUpApplyBtn(_ sender: Any) {
        // 요일 눌린거 확인
        for i in 0...6 {
            // 요일 눌린거 확인
            if dateBtns[i].status == true {
                SignUpUserInfo.shared.daysBtn?.append(i+1)
                if let filterDict = dict["days"] {
                    dict["days"] = filterDict + [i+1]
                }
                else {
                    dict["days"] = [i+1]
                }
                print("요일",i+1)
            }
        }
        // 종목 눌린거 확인
        for i in 0...5 {
            if sportsBtns[i].status == true {
                SignUpUserInfo.shared.sportsListBtn?.append(i+1)
                if let filterDict = dict["sportsList"] {
                    dict["sportsList"] = filterDict + [i+1]
                }
                else {
                    dict["sportsList"] = [i+1]
                }
                print("종목",i+1)
            }
        }
        // 연령대 눌린거 확인
        for i in 0...5 {
            if ageBtns[i].status == true {
                SignUpUserInfo.shared.ageListBtn?.append(i+1)
                if let filterDict = dict["ageList"] {
                    dict["ageList"] = filterDict + [i+1]
                }
                else {
                    dict["ageList"] = [i+1]
                }
                print("연령대",i+1)
            }
        }
        // 크루원수 눌린거 확인
        for i in 0...4 {
            if crewCountBtns[i].status == true {
                SignUpUserInfo.shared.memberCountValueBtn? = i+1
                
                dict["memberCountValue"] = [i+1]
                print("크루원수",i+1)
            }
        }
        
        UserDefaults.standard.set(dict, forKey: "filterParams")
        print("크루필터적용하기", UserDefaults.standard.dictionary(forKey: "filterParams"))
        navigationController?.popViewController(animated: true)
    }
}

// 필터 조회 api
extension CrewFilterVC {
    func didSuccessLookUpCrewFilter(result: LookUpCrewFilterResult) {
        print("필터 조회 데이터가 성공적으로 들어왔습니다.")
        
        // 종목 값이 있으면
        if let sports = result.crewPickSportsList {
            for i in sports {
                sportsBtns[i-1].colorSportsBtn()
            }
        }
        
        // 연령대 값이 있으면
        if let age = result.crewPickAgeList {
            for i in age {
                ageBtns[i-1].colorSportsBtn()
            }
        }
        
        // 요일 값이 있으면
        if let day = result.crewPickDays {
            for i in day {
                dateBtns[i-1].colorSportsBtn()
            }
        }
        
        // 크루원 수가 있으면
//        if let crewCount = result.crewPickMemberCountValue {
//            crewCountBtns[crewCount-1].colorSportsBtn()
//        }
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}
