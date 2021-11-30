//
//  BungaeFilterVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/20.
//

import UIKit

// 번개 필터 VC
class BungaeFilterVC: UIViewController {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: LabelFontSize!
    
    @IBOutlet weak var sportsLabel: LabelFontSize!
    @IBOutlet var sportsBtn: [SportsBtn]!
    
    @IBOutlet weak var dateLabel: LabelFontSize!
    @IBOutlet var dateBtns: [SportsBtn]!
    
    @IBOutlet var countLabel: LabelFontSize!
    @IBOutlet var countBtns: [SportsBtn]!
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var applyBtn: NextBtn!
    
    var bungaeDict = [String:[Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    
    }
    
    private func setStyle() {
        // applyBtn default
        applyBtn.colorNextBtnStyle()
        
        // resetBtn
        resetBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        resetBtn.tintColor = .gray02
        
        // 요일 중복 선택 가능
        for i in 0...6 {
            dateBtns[i].graySportsBtn()
        }
    }

    @IBAction func touchUpDateFirstBtn(_ sender: Any) {
        if sportsBtn[0].status == false {
            sportsBtn[0].colorSportsBtn()
            sportsBtn[1].defaultSportsBtn()
            sportsBtn[2].defaultSportsBtn()
            sportsBtn[3].defaultSportsBtn()
        }
        else {
            sportsBtn[0].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpDateSecBtn(_ sender: Any) {
        if sportsBtn[1].status == false {
            sportsBtn[1].colorSportsBtn()
            sportsBtn[0].defaultSportsBtn()
            sportsBtn[2].defaultSportsBtn()
            sportsBtn[3].defaultSportsBtn()
        }
        else {
            sportsBtn[1].defaultSportsBtn()
        }
    }
    @IBAction func touchUpDateThirdBtn(_ sender: Any) {
        if sportsBtn[2].status == false {
            sportsBtn[2].colorSportsBtn()
            sportsBtn[0].defaultSportsBtn()
            sportsBtn[1].defaultSportsBtn()
            sportsBtn[3].defaultSportsBtn()
        }
        else {
            sportsBtn[2].defaultSportsBtn()
        }
    }
    @IBAction func touchUpDateFourthBtn(_ sender: Any) {
        if sportsBtn[3].status == false {
            sportsBtn[3].colorSportsBtn()
            sportsBtn[0].defaultSportsBtn()
            sportsBtn[1].defaultSportsBtn()
            sportsBtn[2].defaultSportsBtn()
        }
        else {
            sportsBtn[3].defaultSportsBtn()
        }
    }
    
    
    @IBAction func touchUpBungaeCountFirst(_ sender: Any) {
        if countBtns[0].status == false {
            countBtns[0].colorSportsBtn()
            countBtns[1].defaultSportsBtn()
            countBtns[2].defaultSportsBtn()
            countBtns[3].defaultSportsBtn()
        }
        else {
            countBtns[0].defaultSportsBtn()
        }
    }
    @IBAction func touchUpBungaeCountSec(_ sender: Any) {
        if countBtns[1].status == false {
            countBtns[1].colorSportsBtn()
            countBtns[0].defaultSportsBtn()
            countBtns[2].defaultSportsBtn()
            countBtns[3].defaultSportsBtn()
        }
        else {
            countBtns[1].defaultSportsBtn()
        }
    }
    @IBAction func touchUpBungaeCountThird(_ sender: Any) {
        if countBtns[2].status == false {
            countBtns[2].colorSportsBtn()
            countBtns[0].defaultSportsBtn()
            countBtns[1].defaultSportsBtn()
            countBtns[3].defaultSportsBtn()
        }
        else {
            countBtns[2].defaultSportsBtn()
        }
    }
    @IBAction func touchUpBungaeCountFourth(_ sender: Any){
        if countBtns[3].status == false {
            countBtns[3].colorSportsBtn()
            countBtns[0].defaultSportsBtn()
            countBtns[1].defaultSportsBtn()
            countBtns[2].defaultSportsBtn()
        }
        else {
            countBtns[3].defaultSportsBtn()
        }
    }
    
    
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
   // 적용하기 버튼
    @IBAction func touchUpApplyBtn(_ sender: Any) {
        // 요일 눌린거 확인
        for i in 0...6 {
            // 요일 눌린거 확인
            if dateBtns[i].status == true {
                if let filterDict = bungaeDict["days"] {
                    bungaeDict["days"] = filterDict + [i+1]
                }
                else {
                    bungaeDict["days"] = [i+1]
                }
                print("요일",i+1)
            }
        }
        // 일정 눌린거 확인
        for i in 0...3 {
            if sportsBtn[i].status == true {
                bungaeDict["scheduleIndex"] = [i+1]
                
                print("일정",i+1)
            }
        }
        // 모집인원 눌린거 확인
        for i in 0...3 {
            if countBtns[i].status == true {
                bungaeDict["memberCountIndex"] = [i+1]
                
                print("크루원수",i+1)
            }
        }
        
        UserDefaults.standard.set(bungaeDict, forKey: "bungaeFilterParams")
        print("번개필터적용하기", UserDefaults.standard.dictionary(forKey: "bungaeFilterParams"))
        navigationController?.popViewController(animated: true)
        
    }
    
    // 초기화 버튼
    @IBAction func touchUpResetBtn(_ sender: Any) {
        for i in 0...3 {
            if sportsBtn[i].status == true || countBtns[i].status == true {
                sportsBtn[i].defaultSportsBtn()
                countBtns[i].defaultSportsBtn()
            }
        }
        for i in 0...6 {
            if dateBtns[i].status == true {
                dateBtns[i].defaultSportsBtn()
            }
        }
        bungaeDict = [String:[Any]]()
        print("초기화")
    }
}
