//
//  CrewApplicationVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit

protocol GuestModalDelegate {
    func modalDismiss()
    func selectBtnToOpenPopup()
}

class CrewApplicationVC: UIViewController {
    
    var guestModalDelegate : GuestModalDelegate?
    var guestInfoResult : GuestInfoResult?
    lazy var guestRegister = GuestRegisterService()
    lazy var guestInfo = GuestInfoService()
    
    @IBOutlet weak var guestDuesLabel: UILabel!
    @IBOutlet weak var popUpBgView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet var circleBtns: [GuestDateBtn]!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var thirdContentLabel: UILabel!
    @IBOutlet weak var secondSubContentLabel: UILabel!
    @IBOutlet weak var secondContentLabel: UILabel!
    @IBOutlet weak var firstContentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guestInfo.getGuestInfo(delegate: self)
        setStyle()
    }
    
    func stringDate(doubleDate: Double) -> String {
        let doubleToString = String(doubleDate)
        let stringChange = doubleToString.split(separator: ".")
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        return stringDate
    }
    
    private func setStyle() {
        popUpBgView.layer.cornerRadius = 16.adjusted
        
        titleLabel.textColor = .bk
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 26.adjusted)
        
        lineView.backgroundColor = .gray03
        
        firstContentLabel.textColor = .bk
        firstContentLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        secondContentLabel.textColor = .bk
        secondContentLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        secondSubContentLabel.textColor = .gray02
        secondSubContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        guestDuesLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        guestDuesLabel.textColor = .bk
        
        secondSubContentLabel.setTextWithLineHeight(text: secondSubContentLabel.text, lineHeight: 22.adjusted)
        
        thirdContentLabel.textColor = .bk
        thirdContentLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        selectBtn.backgroundColor = .gray03
        selectBtn.tintColor = .wht
        selectBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        selectBtn.layer.cornerRadius = 8.adjusted
        
        for i in 0...2 {
            circleBtns[i].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
            circleBtns[i].setTitleColor(UIColor.bk, for: .normal)
        }
    }
    
    @IBAction func touchUpFirstCircleBtn(_ sender: Any) {
        circleBtns[0].changeBtnImg()
        selectBtn.backgroundColor = .bk
        if circleBtns[0].status {
            circleBtns[1].defaultCheckStyle()
            circleBtns[2].defaultCheckStyle()
        }
    }
    
    @IBAction func touchUpSecondCircleBtn(_ sender: Any) {
        circleBtns[1].changeBtnImg()
        selectBtn.backgroundColor = .bk
        if circleBtns[1].status {
            circleBtns[0].defaultCheckStyle()
            circleBtns[2].defaultCheckStyle()
        }
    }
    
    @IBAction func touchUpThirdCircleBtn(_ sender: Any) {
        circleBtns[2].changeBtnImg()
        selectBtn.backgroundColor = .bk
        if circleBtns[2].status {
            circleBtns[0].defaultCheckStyle()
            circleBtns[1].defaultCheckStyle()
        }
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        guestModalDelegate?.modalDismiss()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpSelectBtn(_ sender: Any) {
        if selectBtn.backgroundColor == .bk {
            for i in 0...2 {
                if circleBtns[i].status == true {
                    guestRegister.postMakeCrew(GuestRegisterRequest(crewID: UserDefaults.standard.integer(forKey: "clubID"), date: circleBtns[i].titleLabel?.text ?? ""), delegate: self)
                    print("dfd", circleBtns[i].titleLabel?.text)
                }
            }
            guestModalDelegate?.modalDismiss()
            // 디스미스되고 손님신청완료 팝업 나옴
            dismiss(animated: true, completion: {
                self.guestModalDelegate?.selectBtnToOpenPopup()
            })
        }
        else {
            selectBtn.backgroundColor = .gray03
        }
    }
}

extension CrewApplicationVC {
    func didSuccessGuestRegister(result: GuestRegisterData) {
        print("게스트 참여가 성공적으로 들어옵니다.")
    }
    
    func didSuccessGuestInfo(result: GuestInfoResult) {
        print("게스트 참여 정보가 성공적으로 들어옵니다.")
        guestInfoResult = result
        guestDuesLabel.text = String(result.guestDue) + "원 입니다."
        guestDuesLabel.asColor(targetString: String(result.guestDue) + "원", color: .main)
        if result.localDates.count <= 1 {
            circleBtns[0].setTitle(result.localDates[0], for: .normal)
            circleBtns[1].isHidden = true
            circleBtns[2].isHidden = true
        }
        else if result.localDates.count <= 2 {
            for i in 0...1 {
                circleBtns[i].setTitle(result.localDates[i], for: .normal)
                circleBtns[2].isHidden = true
            }
        }
        else if result.localDates.count <= 3 {
            for i in 0...2 {
                circleBtns[i].setTitle(result.localDates[i], for: .normal)
            }
        }
    }

    func failedToRequest(message: String) {
        print("크루 디테일 조회 데이터가 들어오지 않았습니다.")
    }
}
