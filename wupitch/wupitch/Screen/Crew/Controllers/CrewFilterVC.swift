//
//  CrewFilterVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import UIKit

class CrewFilterVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: LabelFontSize!
    
    @IBOutlet weak var sportsLabel: LabelFontSize!
    @IBOutlet var sportsBtns: [SportsBtn]!
    
    @IBOutlet weak var dateLabel: LabelFontSize!
    @IBOutlet var dateBtns: [SportsBtn]!
    
    @IBOutlet weak var timeLabel: LabelFontSize!
    @IBOutlet weak var startTimeTextField: tapTextField!
    @IBOutlet weak var betweenLabel: UILabel!
    @IBOutlet weak var endTImeTextField: tapTextField!
    
    @IBOutlet weak var crewCountLabel: LabelFontSize!
    @IBOutlet var crewCountBtns: [SportsBtn]!
    
    @IBOutlet weak var ageLabel: LabelFontSize!
    @IBOutlet var ageBtns: [SportsBtn]!
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var applyBtn: NextBtn!
    
    var timePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        showStartDatePicker()
        showEndDatePicker()
    }
    
    private func setStyle() {
        // textfield placeholder default color
        startTimeTextField.attributedPlaceholder = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        endTImeTextField.attributedPlaceholder = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        betweenLabel.textColor = .gray02
        
        // applyBtn default
        applyBtn.colorNextBtnStyle()
        
        // resetBtn
        resetBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        resetBtn.tintColor = .gray02
        
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
    
    func showStartDatePicker(){
        //Formate Date
        timePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        timePicker.locale = Locale(identifier: "ko-KR")
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        startTimeTextField.inputAccessoryView = toolbar
        startTimeTextField.inputView = timePicker
    }
    
    // 확인
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        startTimeTextField.text = formatter.string(from: timePicker.date)
        startTimeTextField.colorTapTextFiledStyle()
        self.view.endEditing(true)
    }
    
    // 취소
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func showEndDatePicker(){
        //Formate Date
        timePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        timePicker.locale = Locale(identifier: "ko-KR")
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(doneBtn));
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelBtn = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelBtn));
        
        toolbar.setItems([cancelBtn,spaceBtn,doneBtn], animated: false)
        
        endTImeTextField.inputAccessoryView = toolbar
        endTImeTextField.inputView = timePicker
    }
    
    // 확인
    @objc func doneBtn(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        endTImeTextField.text = formatter.string(from: timePicker.date)
        endTImeTextField.colorTapTextFiledStyle()
        betweenLabel.textColor = .main
        self.view.endEditing(true)
    }
    
    // 취소
    @objc func cancelBtn(){
        self.view.endEditing(true)
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
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
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
        startTimeTextField.defaultTapTextFiledStyle()
        startTimeTextField.textColor = .gray02
        endTImeTextField.defaultTapTextFiledStyle()
        endTImeTextField.textColor = .gray02
        betweenLabel.textColor = .gray02
    }
    
    @IBAction func touchUpApplyBtn(_ sender: Any) {
        // 요일 눌린거 확인
        for i in 0...6 {
            // 요일 눌린거 확인
            if dateBtns[i].status == true {
                print("요일",i)
            }
        }
        // 종목 눌린거 확인
        for i in 0...5 {
            if sportsBtns[i].status == true {
                print("종목",i)
            }
        }
        // 연령대 눌린거 확인
        for i in 0...5 {
            if ageBtns[i].status == true {
                print("연령대",i)
            }
        }
        // 크루원수 눌린거 확인
        for i in 0...4 {
            if crewCountBtns[i].status == true {
                print("크루원수",i)
            }
        }
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}


