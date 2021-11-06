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
    @IBOutlet var btnsDateLabel: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    private func setStyle() {
        popUpBgView.layer.cornerRadius = 16.adjusted
        
        titleLabel.textColor = .bk
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 26.adjusted)
        
        lineView.backgroundColor = .gray03
        
        firstContentLabel.textColor = .bk
        firstContentLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        firstContentLabel.setTextWithLineHeight(text: firstContentLabel.text, lineHeight: 22.adjusted)
        
        secondContentLabel.textColor = .bk
        secondContentLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        secondContentLabel.setTextWithLineHeight(text: secondContentLabel.text, lineHeight: 22.adjusted)
        secondContentLabel.asColor(targetString: "10,000원", color: .main)
        secondSubContentLabel.textColor = .gray02
        secondSubContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        secondSubContentLabel.setTextWithLineHeight(text: secondSubContentLabel.text, lineHeight: 22.adjusted)
        
        thirdContentLabel.textColor = .bk
        thirdContentLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        thirdContentLabel.setTextWithLineHeight(text: thirdContentLabel.text, lineHeight: 22.adjusted)
        
        selectBtn.backgroundColor = .gray03
        selectBtn.tintColor = .wht
        selectBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        selectBtn.layer.cornerRadius = 8.adjusted
        
        btnsDateLabel[0].font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        btnsDateLabel[0].setTextWithLineHeight(text: btnsDateLabel[0].text, lineHeight: 22.adjusted)
        btnsDateLabel[0].textColor = .bk
        
        btnsDateLabel[1].font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        btnsDateLabel[1].setTextWithLineHeight(text: btnsDateLabel[1].text, lineHeight: 22.adjusted)
        btnsDateLabel[1].textColor = .bk
        
        btnsDateLabel[2].font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        btnsDateLabel[2].setTextWithLineHeight(text: btnsDateLabel[2].text, lineHeight: 22.adjusted)
        btnsDateLabel[2].textColor = .bk
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
            guestModalDelegate?.modalDismiss()
            // 디스미스되고 손님신청완료 팝업 나옴
            dismiss(animated: true, completion: {
                self.guestModalDelegate?.selectBtnToOpenPopup()
            }
            )}
        else {
            selectBtn.backgroundColor = .gray03
        }
    }
}
