//
//  CrewFilterVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import UIKit

class CrewFilterVC: UIViewController {
    
    @IBOutlet weak var endTimeBtn: UIButton!
    @IBOutlet weak var betweenLabel: UILabel!
    @IBOutlet weak var startTimeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: LabelFontSize!
    
    @IBOutlet weak var sportsLabel: LabelFontSize!
    @IBOutlet var sportsBtns: [SportsBtn]!
    
    @IBOutlet weak var dateLabel: LabelFontSize!
    @IBOutlet var dateBtns: [SportsBtn]!
    
    @IBOutlet weak var timeLabel: LabelFontSize!
    
    @IBOutlet weak var crewCountLabel: LabelFontSize!
    @IBOutlet var crewCountBtns: [SportsBtn]!
    
    @IBOutlet weak var ageLabel: LabelFontSize!
    @IBOutlet var ageBtns: [SportsBtn]!
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var applyBtn: NextBtn!
    
    var timePicker = UIDatePicker()
    var isTextFieldEditing : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        textFieldDelegate()
    }
    
    private func setStyle() {
        startTimeBtn.setTitleColor(UIColor.gray02, for: .normal)
        endTimeBtn.setTitleColor(UIColor.gray02, for: .normal)
        betweenLabel.textColor = .gray02
        startTimeBtn.makeRounded(cornerRadius: 8.adjusted)
        endTimeBtn.makeRounded(cornerRadius: 8.adjusted)
        startTimeBtn.layer.borderWidth = 1.adjusted
        endTimeBtn.layer.borderWidth = 1.adjusted
        startTimeBtn.layer.borderColor = UIColor.gray02.cgColor
        endTimeBtn.layer.borderColor = UIColor.gray02.cgColor
        startTimeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        endTimeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        
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
    
    func textFieldDelegate() {
        //startTectField.delegate = self
        //endTimeTextField.delegate = self
    }
    
    
    
    @IBAction func touchUpStartTimeBtn(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = Locale(identifier: "ko-KR")
        alertVC.view.addSubview(datePicker)
        alertVC.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: alertVC.view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: alertVC.view.trailingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: alertVC.view.topAnchor, constant: 10).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: alertVC.view.bottomAnchor, constant: -120).isActive = true
        
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let dateString = dateFormatter.string(from: datePicker.date)
            
            // 여기서 두 개 나누고 토스트 버튼까지 띄우면 됌
            self.startTimeBtn.setTitle(dateString, for: .normal)
            self.startTimeBtn.setTitleColor(UIColor.main, for: .normal)
            self.startTimeBtn.layer.borderColor = UIColor.main.cgColor
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    @IBAction func touchUpEndTimeBtn(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = Locale(identifier: "ko-KR")
        alertVC.view.addSubview(datePicker)
        alertVC.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: alertVC.view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: alertVC.view.trailingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: alertVC.view.topAnchor, constant: 10).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: alertVC.view.bottomAnchor, constant: -120).isActive = true
        
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let dateString = dateFormatter.string(from: datePicker.date)
            
            // 여기서 두 개 나누고 토스트 버튼까지 띄우면 됌
            let date = Date()
            let date1 = Calendar.current.date(byAdding: .day, value: 1, to: date)
            let distanceHour = Calendar.current.dateComponents([.hour], from: date, to: date1!).hour
            let distanceSecond = Calendar.current.dateComponents([.second], from: date, to: date1!).second
            print("뭐나와", distanceHour)
            print("분", distanceSecond)
            
            self.endTimeBtn.setTitle(dateString, for: .normal)
            self.endTimeBtn.setTitleColor(UIColor.main, for: .normal)
            self.endTimeBtn.layer.borderColor = UIColor.main.cgColor
            self.betweenLabel.textColor = .main
            
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
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
        //startTimeTextField.defaultTapTextFiledStyle()
        //startTimeTextField.textColor = .gray02
        //endTImeTextField.defaultTapTextFiledStyle()
        //endTImeTextField.textColor = .gray02
        //betweenLabel.textColor = .gray02
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

//extension CrewFilterVC: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//

//            textField.resignFirstResponder()
//            let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
//            let datePicker = UIDatePicker()
//            datePicker.datePickerMode = .time
//            if #available(iOS 13.4, *) {
//                datePicker.preferredDatePickerStyle = .wheels
//            } else {
//                // Fallback on earlier versions
//            }
//            datePicker.locale = Locale(identifier: "ko-KR")
//            alertVC.view.addSubview(datePicker)
//            alertVC.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
//            datePicker.translatesAutoresizingMaskIntoConstraints = false
//            datePicker.leadingAnchor.constraint(equalTo: alertVC.view.leadingAnchor).isActive = true
//            datePicker.trailingAnchor.constraint(equalTo: alertVC.view.trailingAnchor).isActive = true
//            datePicker.topAnchor.constraint(equalTo: alertVC.view.topAnchor, constant: 10).isActive = true
//            datePicker.bottomAnchor.constraint(equalTo: alertVC.view.bottomAnchor, constant: -120).isActive = true
//
//            let okAction = UIAlertAction(title: "확인", style: .default) { _ in
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "HH:mm"
//                let dateString = dateFormatter.string(from: datePicker.date)
//
//                // 여기서 두 개 나누고 토스트 버튼까지 띄우면 됌
//                self.startTectField.text = dateString
//                self.startTectField.textColor = .main
//                self.startTectField.layer.borderColor = UIColor.main.cgColor
//            }
//            alertVC.addAction(okAction)
//            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//            alertVC.addAction(cancelAction)
//
//            present(alertVC, animated: true, completion: nil)


//            textField.resignFirstResponder()
//            let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
//            let datePicker = UIDatePicker()
//            datePicker.datePickerMode = .time
//            if #available(iOS 13.4, *) {
//                datePicker.preferredDatePickerStyle = .wheels
//            } else {
//                // Fallback on earlier versions
//            }
//            datePicker.locale = Locale(identifier: "ko-KR")
//            alertVC.view.addSubview(datePicker)
//            alertVC.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
//            datePicker.translatesAutoresizingMaskIntoConstraints = false
//            datePicker.leadingAnchor.constraint(equalTo: alertVC.view.leadingAnchor).isActive = true
//            datePicker.trailingAnchor.constraint(equalTo: alertVC.view.trailingAnchor).isActive = true
//            datePicker.topAnchor.constraint(equalTo: alertVC.view.topAnchor, constant: 10).isActive = true
//            datePicker.bottomAnchor.constraint(equalTo: alertVC.view.bottomAnchor, constant: -120).isActive = true
//
//            let okAction = UIAlertAction(title: "확인", style: .default) { _ in
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "HH:mm"
//                let dateString = dateFormatter.string(from: datePicker.date)
//
//                // 여기서 두 개 나누고 토스트 버튼까지 띄우면 됌
//                self.endTimeTextField.text = dateString
//                self.endTimeTextField.textColor = .main
//                self.endTimeTextField.layer.borderColor = UIColor.main.cgColor
//                self.betweenLabel.textColor = .main
//            }
//            alertVC.addAction(okAction)
//            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//            alertVC.addAction(cancelAction)
//
//            present(alertVC, animated: true, completion: nil)

//    }
//}
