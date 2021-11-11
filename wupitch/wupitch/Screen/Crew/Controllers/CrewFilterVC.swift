//
//  CrewFilterVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import UIKit

class CrewFilterVC: UIViewController {

    @IBOutlet weak var endTimeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: LabelFontSize!
    
    @IBOutlet weak var sportsLabel: LabelFontSize!
    @IBOutlet var sportsBtns: [SportsBtn]!
    
    @IBOutlet weak var dateLabel: LabelFontSize!
    @IBOutlet var dateBtns: [SportsBtn]!
    
    @IBOutlet weak var timeLabel: LabelFontSize!
    
   
    @IBOutlet weak var startTectField: UITextField!
    
    
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
        textFieldToAddTarget()
        //startTectField.tintColor = .clear
        //startTectField.selectedTextRange = nil
    }
    private func setStyle() {
        // textfield placeholder default color
        //startTimeTextField.attributedPlaceholder = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
//        endTImeTextField.attributedPlaceholder = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        
        // textField Style
        startTectField.tintColor = .clear
        startTectField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        startTectField.attributedPlaceholder = NSAttributedString(string: "지역구 선택", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray02])
        startTectField.layer.borderColor = UIColor.gray02.cgColor
//        test.layer.borderWidth = 1.adjusted
//        test.layer.cornerRadius = 8.adjusted
//
//        betweenLabel.textColor = .gray02
        
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
    

    // 텍스트 필드 눌렀을 때 addTarget주기
    func textFieldToAddTarget() {
        startTectField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
    }
    
    // textFieldToAddTarget()의 addTarget
    @objc func textFieldDidChange(_ textField:UITextField) {
        
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
            self.startTectField.text = dateString
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertVC.addAction(cancelAction)

        present(alertVC, animated: true, completion: nil)
       
    }
    
    
    @IBAction func touchUpTimePicker(_ sender: Any) {
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
            self.endTimeBtn.setTitle(dateString, for: .normal)
            //self.startTimeTextField.text = dateString
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertVC.addAction(cancelAction)

        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func touchUpCrewCountFirst(_ sender: Any) {
        
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
            self.ageLabel.text = dateString
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertVC.addAction(cancelAction)
        
        
        self.present(alertVC, animated: true, completion: nil)
             

        
        
        
        
//        if crewCountBtns[0].status == false {
//            crewCountBtns[0].colorSportsBtn()
//            crewCountBtns[1].defaultSportsBtn()
//            crewCountBtns[2].defaultSportsBtn()
//            crewCountBtns[3].defaultSportsBtn()
//            crewCountBtns[4].defaultSportsBtn()
//        }
//        else {
//            crewCountBtns[0].defaultSportsBtn()
//        }
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
//    func start() {
//        startTimeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
//    }
//
//    @objc func textFieldDidChange() {
//        let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .time
//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .wheels
//        } else {
//            // Fallback on earlier versions
//        }
//        datePicker.locale = Locale(identifier: "ko-KR")
//        alertVC.view.addSubview(datePicker)
//        alertVC.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        datePicker.leadingAnchor.constraint(equalTo: alertVC.view.leadingAnchor).isActive = true
//        datePicker.trailingAnchor.constraint(equalTo: alertVC.view.trailingAnchor).isActive = true
//        datePicker.topAnchor.constraint(equalTo: alertVC.view.topAnchor, constant: 10).isActive = true
//        datePicker.bottomAnchor.constraint(equalTo: alertVC.view.bottomAnchor, constant: -120).isActive = true
//
//        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "HH:mm"
//            let dateString = dateFormatter.string(from: datePicker.date)
//            self.startTimeTextField.text = dateString
//        }
//        alertVC.addAction(okAction)
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//        alertVC.addAction(cancelAction)
//
//        //startTimeTextField.inputView = datePicker
//        present(alertVC, animated: true, completion: nil)
//
//    }
//}
