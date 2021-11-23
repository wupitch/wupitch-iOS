//
//  MakeCrewDateVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewDateVC: UIViewController {

    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var toastView: UIView!
    @IBOutlet weak var toastMessageLabel: UILabel!
    @IBOutlet var betweenLabels: [UILabel]!
    @IBOutlet var endTimeBtns: [UIButton]!
    @IBOutlet var startTimeBtns: [UIButton]!
    @IBOutlet var dateBtns: [DateBtn]!
    @IBOutlet weak var secondBgView: UIView!
    @IBOutlet weak var firstBgView: UIView!
    @IBOutlet var addBtn: [UIButton]!
    
    var isFirstStartDatePicker : String?
    var isSecondStartDatePicker : String?
    var isThirdStartDatePicker : String?
    
    var isFirstEndDatePicker : String?
    var isSecondEndDatePicker : String?
    var isThirdEndDatePicker : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateBtns.forEach { $0.dateDelegate = self }
        
        toastView.alpha = 0.0
        addBtn[0].makeRounded(cornerRadius: nil)
        addBtn[1].makeRounded(cornerRadius: nil)
        
        toastView.makeRounded(cornerRadius: 16.adjusted)
        toastMessageLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        firstBgView.isHidden = false
        secondBgView.isHidden = false
        
        setTimeBtn()
    }
    
//    func setBtn(i:Int) {
//        startTimeBtns[i].setTitleColor(UIColor.gray02, for: .normal)
//        startTimeBtns[i].setTitle("00:00", for: .normal)
//        endTimeBtns[i].setTitle("00:00", for: .normal)
//        endTimeBtns[i].setTitleColor(UIColor.gray02, for: .normal)
//        betweenLabels[i].textColor = .gray02
//        startTimeBtns[i].makeRounded(cornerRadius: 8.adjusted)
//        endTimeBtns[i].makeRounded(cornerRadius: 8.adjusted)
//        startTimeBtns[i].layer.borderWidth = 1.adjusted
//        endTimeBtns[i].layer.borderWidth = 1.adjusted
//        startTimeBtns[i].layer.borderColor = UIColor.gray02.cgColor
//        endTimeBtns[i].layer.borderColor = UIColor.gray02.cgColor
//        startTimeBtns[i].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
//        endTimeBtns[i].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
//    }
    
    func setTimeBtn() {
        for i in 0...2 {
            startTimeBtns[i].setTitleColor(UIColor.gray02, for: .normal)
            startTimeBtns[i].setTitle("00:00", for: .normal)
            endTimeBtns[i].setTitle("00:00", for: .normal)
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
        isFirstStartDatePicker = nil
        isSecondStartDatePicker = nil
        isThirdStartDatePicker = nil
        
        isFirstEndDatePicker = nil
        isSecondEndDatePicker = nil
        isThirdEndDatePicker = nil
    }
    
    // 토스트 메시지
    func showToast(message:String) {
        toastMessageLabel.text = message
        self.toastView?.alpha = 1.0
        UIView.animate(withDuration: 4.0, delay: 0.01, animations: {
            self.toastView.alpha = 0.0
        }, completion: nil)
    }
    
    func dateLogic(index: Int) {
        if dateBtns[index].status == true {
            nextBtn.backgroundColor = .main
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
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
            self.isFirstStartDatePicker = dateString
            
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
        
        let okAction = UIAlertAction(title: "확인", style: .default) { [self] _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let dateString = dateFormatter.string(from: datePicker.date)

            if let pickerData = self.isFirstStartDatePicker {
                if pickerData < dateString {
                    print(pickerData)
                    print(dateString)
                    self.endTimeBtns[0].setTitle(dateString, for: .normal)
                    self.endTimeBtns[0].setTitleColor(UIColor.main, for: .normal)
                    self.endTimeBtns[0].layer.borderColor = UIColor.main.cgColor
                    self.betweenLabels[0].textColor = .main
                    self.isFirstEndDatePicker = dateString
                    
                    for i in 0...6 {
                        dateLogic(index: i)
                    }

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
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewPhoto", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewPhotoVC") as? MakeCrewPhotoVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func touchUpAddBtn(_ sender: UIButton) {
        if firstBgView.isHidden == false && nextBtn.backgroundColor == .main {
            addBtn[0].setImage(UIImage(named: "subtract"), for: .normal)
            firstBgView.isHidden = true
            print("이프눌린다")
        }
        else {
            if firstBgView.isHidden == true && secondBgView.isHidden == false {
                addBtn[0].setImage(UIImage(named: "add"), for: .normal)
                firstBgView.isHidden = false
                for i in 7...13 {
                    //dateBtns[i].defaultSportsBtn()
                }
                //setBtn(i:1)
                isSecondStartDatePicker = nil
                isSecondEndDatePicker = nil
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
            self.isSecondStartDatePicker = dateString
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
            
            if let pickerData = self.isSecondStartDatePicker {
                if pickerData < dateString {
                    print(pickerData)
                    print(dateString)
                    self.endTimeBtns[1].setTitle(dateString, for: .normal)
                    self.endTimeBtns[1].setTitleColor(UIColor.main, for: .normal)
                    self.endTimeBtns[1].layer.borderColor = UIColor.main.cgColor
                    self.betweenLabels[1].textColor = .main
                    self.isSecondEndDatePicker = dateString
                    
                    
//                        for i in 7...13 {
//                            self.dateLogic(index: i)
//                        }
                    
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
            self.isThirdStartDatePicker = dateString
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
            
            if let pickerData = self.isThirdStartDatePicker {
                if pickerData < dateString {
                    print(pickerData)
                    print(dateString)
                    self.endTimeBtns[2].setTitle(dateString, for: .normal)
                    self.endTimeBtns[2].setTitleColor(UIColor.main, for: .normal)
                    self.endTimeBtns[2].layer.borderColor = UIColor.main.cgColor
                    self.betweenLabels[2].textColor = .main
                    self.isThirdEndDatePicker = dateString
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

extension MakeCrewDateVC : DateDelegate {
    func clickDate(btn: DateBtn) {
        guard let buttonIndex = dateBtns.firstIndex(of: btn) else { return }
        switch buttonIndex {
        case 0...6 :
            for i in 0...6 {
                if i != buttonIndex {
                    dateBtns[i].status = false
                }
            }
        case 7...13 :
            for i in 7...13 {
                if i != buttonIndex {
                    dateBtns[i].status = false
                }
            }
        case 14...20 :
            for i in 14...20 {
                if i != buttonIndex {
                    dateBtns[i].status = false
                }
            }
        default:
            break
        }
    }
}
