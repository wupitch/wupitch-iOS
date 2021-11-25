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
    @IBOutlet var endTimeBtns: [DatePickerBtn]!
    @IBOutlet var startTimeBtns: [DatePickerBtn]!
    @IBOutlet var dateBtns: [DateBtn]!
    @IBOutlet weak var secondBgView: UIView!
    @IBOutlet weak var firstBgView: UIView!
    @IBOutlet var addBtn: [UIButton]!
    
    // 플러스 버튼 검사
    var plusBtnCheck = [false, false]
    
    // 요일 버튼 검사
    var dateSectionFirstBtnCheck = [false,false,false,false,false,false,false]
    var dateSectionSecondBtnCheck = [false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    var dateSectionThirdBtnCheck = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    
    // 초기화
    var firstPickerStartData : Double?
    var firstPickerEndData : Double?
//
//    var secondPickerStartData : Double?
//    var secondPickerEndData : Double?
//
//    var thirdPickerStartData : Double?
//    var thirdPickerEndData : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateBtns.forEach { $0.dateDelegate = self }
        startTimeBtns.forEach { $0.datePickerDelegate = self }
        endTimeBtns.forEach { $0.datePickerDelegate = self }
        
        toastView.alpha = 0.0
        addBtn[0].makeRounded(cornerRadius: nil)
        addBtn[1].makeRounded(cornerRadius: nil)
        
        toastView.makeRounded(cornerRadius: 16.adjusted)
        toastMessageLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        
        setTimeBtn()
    }
    
    func setTimeBtn() {
        betweenLabels[0].textColor = .gray02
        betweenLabels[1].textColor = .gray02
        betweenLabels[2].textColor = .gray02
    }
    
    /// check()메서드는 모든 요일, 시간 버튼이 클릭될때마다 호출
    func check() {
        // 섹션 1 검사하는 코드
        // 요일, 시간이 전부 true인지?
        if dateSectionFirstBtnCheck.contains { $0 == true } && startTimeBtns[0].status && endTimeBtns[0].status {
            // true
            nextBtn.backgroundColor = .main
        } else {
            // false
            nextBtn.backgroundColor = .gray03
        }
        
        if plusBtnCheck[0] == true {
            // 섹션 2 검사하는 코드
            // 요일, 시간이 전부 true인지?
            if dateSectionFirstBtnCheck.contains { $0 == true } && dateSectionSecondBtnCheck.contains { $0 == true } && startTimeBtns[1].status && endTimeBtns[1].status {
                // true
                nextBtn.backgroundColor = .main
                
            } else {
                // false
                nextBtn.backgroundColor = .gray03
            }
        }
        
        if plusBtnCheck[1] == true {
            // 섹션 3 검사하는 코드
            // 요일, 시간이 전부 true인지?
            if dateSectionFirstBtnCheck.contains { $0 == true } && dateSectionSecondBtnCheck.contains { $0 == true } && dateSectionThirdBtnCheck.contains { $0 == true } && startTimeBtns[2].status && endTimeBtns[2].status {
                // true
                nextBtn.backgroundColor = .main
            } else {
                // false
                nextBtn.backgroundColor = .gray03
            }
        }
    }
    
    // 토스트 메시지
    func showToast(message:String) {
        toastMessageLabel.text = message
        self.toastView?.alpha = 1.0
        UIView.animate(withDuration: 4.0, delay: 0.01, animations: {
            self.toastView.alpha = 0.0
        }, completion: nil)
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
            plusBtnCheck[0] = true
            print("이프눌린다")
            check()
        }
        else {
            if firstBgView.isHidden == true && secondBgView.isHidden == false {
                addBtn[0].setImage(UIImage(named: "add"), for: .normal)
                firstBgView.isHidden = false
                plusBtnCheck[0] = false
                check()
            }
        }
    }
    
    @IBAction func touchUpAddSecondBtn(_ sender: Any) {
        if firstBgView.isHidden == true && secondBgView.isHidden == false {
            addBtn[1].setImage(UIImage(named: "subtract"), for: .normal)
            secondBgView.isHidden = true
            plusBtnCheck[1] = true
            print("이프눌린다")
            check()
        }
        else {
            addBtn[1].setImage(UIImage(named: "add"), for: .normal)
            secondBgView.isHidden = false
            plusBtnCheck[1] = false
            print("엘즈눌린다")
            check()
        }
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
                dateSectionFirstBtnCheck[i] = dateBtns[i].status
                check()
            }
        case 7...13 :
            for i in 7...13 {
                if i != buttonIndex {
                    dateBtns[i].status = false
                }
                dateSectionSecondBtnCheck[i] = dateBtns[i].status
                check()
            }
            
        case 14...20 :
            for i in 14...20 {
                if i != buttonIndex {
                    dateBtns[i].status = false
                }
                dateSectionThirdBtnCheck[i] = dateBtns[i].status
                check()
            }
        default:
            break
        }
    }
}

extension MakeCrewDateVC : DatePickerDelegate {
    func clickDatePicker(btn: DatePickerBtn) {
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
            
            var value = true
            switch btn {
                
            case startTimeBtns[0] :
                if endTimeBtns[0].status {
                    value = endTimeBtns[0].doubleDatePicker(secondDate: dateString, location: true)
                }
                
            case startTimeBtns[1] :
                if endTimeBtns[1].status {
                    value = endTimeBtns[1].doubleDatePicker(secondDate: dateString, location: true)
                }
                
            case startTimeBtns[2] :
                if endTimeBtns[2].status {
                    value = endTimeBtns[2].doubleDatePicker(secondDate: dateString, location: true)
                }
                
            case endTimeBtns[0] :
                value = startTimeBtns[0].doubleDatePicker(secondDate: dateString, location: false)
                betweenLabels[0].textColor = .main
                
                
            case endTimeBtns[1] :
                value = startTimeBtns[1].doubleDatePicker(secondDate: dateString, location: false)
                betweenLabels[1].textColor = .main
                
            case endTimeBtns[2] :
                value = startTimeBtns[2].doubleDatePicker(secondDate: dateString, location: false)
                betweenLabels[2].textColor = .main
                
            default:
                break
            }
            
            if value == false {
                showToast(message: "종료시간이 시작시간보다 늦어야 해요!")
            }
            else {
                btn.status = true
                btn.setTitle(dateString, for: .normal)
                check()
            }
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true, completion: nil)
    }
}
