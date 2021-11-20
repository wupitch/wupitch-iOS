//
//  CrewFilterVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import UIKit

class CrewFilterVC: UIViewController {
    
    @IBOutlet weak var toastMessageLabel: UILabel!
    @IBOutlet weak var toastView: UIView!
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
    var isPicker : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        textFieldDelegate()
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
    
//    func setTimeBtn() {
//        startTimeBtn.setTitleColor(UIColor.gray02, for: .normal)
//        startTimeBtn.setTitle("00:00", for: .normal)
//        endTimeBtn.setTitle("00:00", for: .normal)
//        endTimeBtn.setTitleColor(UIColor.gray02, for: .normal)
//        betweenLabel.textColor = .gray02
//        startTimeBtn.makeRounded(cornerRadius: 8.adjusted)
//        endTimeBtn.makeRounded(cornerRadius: 8.adjusted)
//        startTimeBtn.layer.borderWidth = 1.adjusted
//        endTimeBtn.layer.borderWidth = 1.adjusted
//        startTimeBtn.layer.borderColor = UIColor.gray02.cgColor
//        endTimeBtn.layer.borderColor = UIColor.gray02.cgColor
//        startTimeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
//        endTimeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
//        isPicker = nil
//    }
    
    func textFieldDelegate() {
        //startTectField.delegate = self
        //endTimeTextField.delegate = self
    }
    
    // 토스트 메시지
    func showToast(message:String) {
        toastMessageLabel.text = message
        self.toastView?.alpha = 1.0
        UIView.animate(withDuration: 4.0, delay: 0.01, animations: {
            self.toastView.alpha = 0.0
        }, completion: nil)
    }
    
    @IBAction func touchUpStartTimeBtn(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 15
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
//        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.locale = Locale(identifier: "en_GB")
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
            
            self.startTimeBtn.setTitle(dateString, for: .normal)
            self.startTimeBtn.setTitleColor(UIColor.main, for: .normal)
            self.startTimeBtn.layer.borderColor = UIColor.main.cgColor
            self.isPicker = dateString
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
        datePicker.minuteInterval = 15
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = Locale(identifier: "en_GB")
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
            
            if let pickerData = self.isPicker {
                if pickerData < dateString {
                    print(pickerData)
                    print(dateString)
                    self.endTimeBtn.setTitle(dateString, for: .normal)
                    self.endTimeBtn.setTitleColor(UIColor.main, for: .normal)
                    self.endTimeBtn.layer.borderColor = UIColor.main.cgColor
                    self.betweenLabel.textColor = .main
                }
                else {
                    self.showToast(message: "종료시간이 시작시간보다 늦어야 해요!")
                }
            }
            else {
                self.showToast(message: "시작시간부터 입력해주세요!")
            }
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
        //setTimeBtn()
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
        var i : String?
        i = startTimeBtn.titleLabel?.text
        var j : String?
        j = endTimeBtn.titleLabel?.text
        print("시작시간", i ?? "값이 없어요")
        print("종료시간", j ?? "값이 없어요")
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
