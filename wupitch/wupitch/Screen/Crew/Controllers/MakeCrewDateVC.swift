//
//  MakeCrewDateVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewDateVC: UIViewController {

    @IBOutlet weak var toastView: UIView!
    @IBOutlet weak var toastMessageLabel: UILabel!
    @IBOutlet var betweenLabels: [UILabel]!
    @IBOutlet var endTimeBtns: [UIButton]!
    @IBOutlet var startTimeBtns: [UIButton]!
    @IBOutlet var weekBtns: [CheckBtn]!
    @IBOutlet var dateBtns: [SportsBtn]!
    @IBOutlet weak var secondBgView: UIView!
    @IBOutlet weak var firstBgView: UIView!
    @IBOutlet var addBtn: [UIButton]!
    
    var isFirstDatePicker : String?
    var isSecondDatePicker : String?
    var isThirdDatePicker : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toastView.alpha = 0.0
        addBtn[0].makeRounded(cornerRadius: nil)
        addBtn[1].makeRounded(cornerRadius: nil)
        
        toastView.makeRounded(cornerRadius: 16.adjusted)
        toastMessageLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        for i in 0...2 {
            weekBtns[i].setTitleColor(.gray02, for: .normal)
            weekBtns[i].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
            weekBtns[i].titleLabel?.setTextWithLineHeight(text: weekBtns[i].titleLabel?.text, lineHeight: 19.adjusted)
            weekBtns[i].grayCheck()
        }
        
        setTimeBtn()
    }
    
    func setTimeBtn() {
        for i in 0...2 {
            startTimeBtns[i].setTitleColor(UIColor.gray02, for: .normal)
            startTimeBtns[i].setTitle("00:00", for: .normal)
            startTimeBtns[i].setTitle("00:00", for: .normal)
            endTimeBtns[i].setTitleColor(UIColor.gray02, for: .normal)
            betweenLabels[i].textColor = .gray02
            startTimeBtns[i].makeRounded(cornerRadius: 8.adjusted)
            endTimeBtns[i].makeRounded(cornerRadius: 8.adjusted)
            startTimeBtns[i].layer.borderWidth = 1.adjusted
            endTimeBtns[i].layer.borderWidth = 1.adjusted
            startTimeBtns[i].layer.borderColor = UIColor.gray02.cgColor
            endTimeBtns[i].layer.borderColor = UIColor.gray02.cgColor
            startTimeBtns[i].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
            endTimeBtns[i].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        }
        isFirstDatePicker = nil
        isSecondDatePicker = nil
        isThirdDatePicker = nil
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
            
            self.startTimeBtns[0].setTitle(dateString, for: .normal)
            self.startTimeBtns[0].setTitleColor(UIColor.main, for: .normal)
            self.startTimeBtns[0].layer.borderColor = UIColor.main.cgColor
            self.isFirstDatePicker = dateString
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
            
            if let pickerData = self.isFirstDatePicker {
                if pickerData < dateString {
                    print(pickerData)
                    print(dateString)
                    self.endTimeBtns[0].setTitle(dateString, for: .normal)
                    self.endTimeBtns[0].setTitleColor(UIColor.main, for: .normal)
                    self.endTimeBtns[0].layer.borderColor = UIColor.main.cgColor
                    self.betweenLabels[0].textColor = .main
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
    
    
    @IBAction func touchUpWeekBtn(_ sender: Any) {
        if weekBtns[0].status == false {
            weekBtns[0].colorCheck()
        }
        else {
            weekBtns[0].grayCheck()
        }
        
    }
    
    @IBAction func touchUpTwoWeekBtn(_ sender: Any) {
        if weekBtns[1].status == false {
            weekBtns[1].colorCheck()
        }
        else {
            weekBtns[1].grayCheck()
        }
        
    }
    
    @IBAction func touchUpThreeWeekBtn(_ sender: Any) {
        if weekBtns[2].status == false {
            weekBtns[2].colorCheck()
        }
        else {
            weekBtns[2].grayCheck()
        }
        
    }
    
    
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewPhoto", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewPhotoVC") as? MakeCrewPhotoVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func touchUpAddBtn(_ sender: UIButton) {
        if firstBgView.isHidden == false {
            addBtn[0].setImage(UIImage(named: "subtract"), for: .normal)
            firstBgView.isHidden = true
            print("이프눌린다")
        }
        else {
            if firstBgView.isHidden == true && secondBgView.isHidden == false {
                addBtn[0].setImage(UIImage(named: "add"), for: .normal)
                firstBgView.isHidden = false
                print("엘즈눌린다")
            }
        }
    }
    
    @IBAction func touchUpAddSecondBtn(_ sender: Any) {
        if firstBgView.isHidden == true && secondBgView.isHidden == false {
            addBtn[1].setImage(UIImage(named: "subtract"), for: .normal)
            secondBgView.isHidden = true
            print("이프눌린다")
        }
        else {
            addBtn[1].setImage(UIImage(named: "add"), for: .normal)
            secondBgView.isHidden = false
            print("엘즈눌린다")
        }
    }
    
    @IBAction func touchUpFirstBtn(_ sender: Any) {
        if dateBtns[0].status == false {
            dateBtns[0].colorSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[0].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSecondBtn(_ sender: Any) {
        if dateBtns[1].status == false {
            dateBtns[1].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[1].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpThirdBtn(_ sender: Any) {
        if dateBtns[2].status == false {
            dateBtns[2].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[2].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpFourthBtn(_ sender: Any) {
        if dateBtns[3].status == false {
            dateBtns[3].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[3].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpFiftnBtn(_ sender: Any) {
        if dateBtns[4].status == false {
            dateBtns[4].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[4].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSixthBtn(_ sender: Any) {
        if dateBtns[5].status == false {
            dateBtns[5].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[6].defaultSportsBtn()
        }
        else {
            dateBtns[5].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSevenxthBtn(_ sender: Any) {
        if dateBtns[6].status == false {
            dateBtns[6].colorSportsBtn()
            dateBtns[0].defaultSportsBtn()
            dateBtns[1].defaultSportsBtn()
            dateBtns[2].defaultSportsBtn()
            dateBtns[3].defaultSportsBtn()
            dateBtns[4].defaultSportsBtn()
            dateBtns[5].defaultSportsBtn()
        }
        else {
            dateBtns[6].defaultSportsBtn()
        }
    }
    
    // 두번째 일정
    @IBAction func touchUpFirsDateBtn(_ sender: Any) {
        if dateBtns[7].status == false {
            dateBtns[7].colorSportsBtn()
            dateBtns[8].defaultSportsBtn()
            dateBtns[9].defaultSportsBtn()
            dateBtns[10].defaultSportsBtn()
            dateBtns[11].defaultSportsBtn()
            dateBtns[12].defaultSportsBtn()
            dateBtns[13].defaultSportsBtn()
        }
        else {
            dateBtns[7].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSecondDateBtn(_ sender: Any) {
        if dateBtns[8].status == false {
            dateBtns[8].colorSportsBtn()
            dateBtns[7].defaultSportsBtn()
            dateBtns[9].defaultSportsBtn()
            dateBtns[10].defaultSportsBtn()
            dateBtns[11].defaultSportsBtn()
            dateBtns[12].defaultSportsBtn()
            dateBtns[13].defaultSportsBtn()
        }
        else {
            dateBtns[8].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpThirdDateBtn(_ sender: Any) {
        if dateBtns[9].status == false {
            dateBtns[9].colorSportsBtn()
            dateBtns[7].defaultSportsBtn()
            dateBtns[8].defaultSportsBtn()
            dateBtns[10].defaultSportsBtn()
            dateBtns[11].defaultSportsBtn()
            dateBtns[12].defaultSportsBtn()
            dateBtns[13].defaultSportsBtn()
        }
        else {
            dateBtns[9].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpFourthDateBtn(_ sender: Any) {
        if dateBtns[10].status == false {
            dateBtns[10].colorSportsBtn()
            dateBtns[7].defaultSportsBtn()
            dateBtns[8].defaultSportsBtn()
            dateBtns[9].defaultSportsBtn()
            dateBtns[11].defaultSportsBtn()
            dateBtns[12].defaultSportsBtn()
            dateBtns[13].defaultSportsBtn()
        }
        else {
            dateBtns[10].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpFiftnDateBtn(_ sender: Any) {
        if dateBtns[11].status == false {
            dateBtns[11].colorSportsBtn()
            dateBtns[7].defaultSportsBtn()
            dateBtns[8].defaultSportsBtn()
            dateBtns[9].defaultSportsBtn()
            dateBtns[10].defaultSportsBtn()
            dateBtns[12].defaultSportsBtn()
            dateBtns[13].defaultSportsBtn()
        }
        else {
            dateBtns[11].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSixthDateBtn(_ sender: Any) {
        if dateBtns[12].status == false {
            dateBtns[12].colorSportsBtn()
            dateBtns[7].defaultSportsBtn()
            dateBtns[8].defaultSportsBtn()
            dateBtns[9].defaultSportsBtn()
            dateBtns[10].defaultSportsBtn()
            dateBtns[11].defaultSportsBtn()
            dateBtns[13].defaultSportsBtn()
        }
        else {
            dateBtns[12].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSevenxthDateBtn(_ sender: Any) {
        if dateBtns[13].status == false {
            dateBtns[13].colorSportsBtn()
            dateBtns[7].defaultSportsBtn()
            dateBtns[8].defaultSportsBtn()
            dateBtns[9].defaultSportsBtn()
            dateBtns[10].defaultSportsBtn()
            dateBtns[11].defaultSportsBtn()
            dateBtns[12].defaultSportsBtn()
        }
        else {
            dateBtns[13].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpDateTwoStartTimeBtn(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
//        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.minuteInterval = 15
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
            
            self.startTimeBtns[1].setTitle(dateString, for: .normal)
            self.startTimeBtns[1].setTitleColor(UIColor.main, for: .normal)
            self.startTimeBtns[1].layer.borderColor = UIColor.main.cgColor
            self.isSecondDatePicker = dateString
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func touchUpDateTwoEndTimeBtn(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.minuteInterval = 15
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
            
            if let pickerData = self.isSecondDatePicker {
                if pickerData < dateString {
                    print(pickerData)
                    print(dateString)
                    self.endTimeBtns[1].setTitle(dateString, for: .normal)
                    self.endTimeBtns[1].setTitleColor(UIColor.main, for: .normal)
                    self.endTimeBtns[1].layer.borderColor = UIColor.main.cgColor
                    self.betweenLabels[1].textColor = .main
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
    
    
    
    // 3번째 일정
    @IBAction func touchUpFirsDateBtnCheck(_ sender: Any) {
        if dateBtns[14].status == false {
            dateBtns[14].colorSportsBtn()
            dateBtns[15].defaultSportsBtn()
            dateBtns[16].defaultSportsBtn()
            dateBtns[17].defaultSportsBtn()
            dateBtns[18].defaultSportsBtn()
            dateBtns[19].defaultSportsBtn()
            dateBtns[20].defaultSportsBtn()
        }
        else {
            dateBtns[14].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSecondDateBtnCheck(_ sender: Any) {
        if dateBtns[15].status == false {
            dateBtns[15].colorSportsBtn()
            dateBtns[14].defaultSportsBtn()
            dateBtns[16].defaultSportsBtn()
            dateBtns[17].defaultSportsBtn()
            dateBtns[18].defaultSportsBtn()
            dateBtns[19].defaultSportsBtn()
            dateBtns[20].defaultSportsBtn()
        }
        else {
            dateBtns[15].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpThirdDateBtnCheck(_ sender: Any) {
        if dateBtns[16].status == false {
            dateBtns[16].colorSportsBtn()
            dateBtns[14].defaultSportsBtn()
            dateBtns[15].defaultSportsBtn()
            dateBtns[17].defaultSportsBtn()
            dateBtns[18].defaultSportsBtn()
            dateBtns[19].defaultSportsBtn()
            dateBtns[20].defaultSportsBtn()
        }
        else {
            dateBtns[16].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpFourthDateBtnCheck(_ sender: Any) {
        if dateBtns[17].status == false {
            dateBtns[17].colorSportsBtn()
            dateBtns[14].defaultSportsBtn()
            dateBtns[15].defaultSportsBtn()
            dateBtns[16].defaultSportsBtn()
            dateBtns[18].defaultSportsBtn()
            dateBtns[19].defaultSportsBtn()
            dateBtns[20].defaultSportsBtn()
        }
        else {
            dateBtns[17].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpFiftnDateBtnCheck(_ sender: Any) {
        if dateBtns[18].status == false {
            dateBtns[18].colorSportsBtn()
            dateBtns[14].defaultSportsBtn()
            dateBtns[15].defaultSportsBtn()
            dateBtns[16].defaultSportsBtn()
            dateBtns[17].defaultSportsBtn()
            dateBtns[19].defaultSportsBtn()
            dateBtns[20].defaultSportsBtn()
        }
        else {
            dateBtns[18].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSixthDateBtnCheck(_ sender: Any) {
        if dateBtns[19].status == false {
            dateBtns[19].colorSportsBtn()
            dateBtns[14].defaultSportsBtn()
            dateBtns[15].defaultSportsBtn()
            dateBtns[16].defaultSportsBtn()
            dateBtns[17].defaultSportsBtn()
            dateBtns[18].defaultSportsBtn()
            dateBtns[20].defaultSportsBtn()
        }
        else {
            dateBtns[19].defaultSportsBtn()
        }
    }
    
    @IBAction func touchUpSevenxthDateBtnCheck(_ sender: Any) {
        if dateBtns[20].status == false {
            dateBtns[20].colorSportsBtn()
            dateBtns[14].defaultSportsBtn()
            dateBtns[15].defaultSportsBtn()
            dateBtns[16].defaultSportsBtn()
            dateBtns[17].defaultSportsBtn()
            dateBtns[18].defaultSportsBtn()
            dateBtns[19].defaultSportsBtn()
        }
        else {
            dateBtns[20].defaultSportsBtn()
        }
    }
    
    
    @IBAction func touchUpDateThreeStartTimeBtn(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
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
            
            self.startTimeBtns[2].setTitle(dateString, for: .normal)
            self.startTimeBtns[2].setTitleColor(UIColor.main, for: .normal)
            self.startTimeBtns[2].layer.borderColor = UIColor.main.cgColor
            self.isThirdDatePicker = dateString
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func touchUpDateThreeEndTimeBtn(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        
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
            
            if let pickerData = self.isThirdDatePicker {
                if pickerData < dateString {
                    print(pickerData)
                    print(dateString)
                    self.endTimeBtns[2].setTitle(dateString, for: .normal)
                    self.endTimeBtns[2].setTitleColor(UIColor.main, for: .normal)
                    self.endTimeBtns[2].layer.borderColor = UIColor.main.cgColor
                    self.betweenLabels[2].textColor = .main
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
    
}
