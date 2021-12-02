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
        
        for i in 0...20 {
            dateBtns[i].dayId = i
        }
    }
    
    func setTimeBtn() {
        betweenLabels[0].textColor = .gray02
        betweenLabels[1].textColor = .gray02
        betweenLabels[2].textColor = .gray02
    }
    
    // 중복체크
    private func duplicateCheck(section:Int, index:Int) {
        var isDuplicate = false
        let idx = index % 7
        switch section {
        case 0:
            if let sectionTwo = (7...13).first(where: { dateBtns[$0].status == true }) {
                if (sectionTwo % 7) == idx { isDuplicate = true }
            }
            if let sectionThree = (14...20).first(where: { dateBtns[$0].status == true }) {
                if (sectionThree % 7) == idx { isDuplicate = true }
            }
        case 1:
            if let sectionOne = (0...6).first(where: { dateBtns[$0].status == true }) {
                if sectionOne == idx { isDuplicate = true }
            }
            if let sectionThree = (14...20).first(where: { dateBtns[$0].status == true }) {
                if (sectionThree % 7) == idx { isDuplicate = true }
            }
        case 2:
            if let sectionOne = (0...6).first(where: { dateBtns[$0].status == true }) {
                if sectionOne == idx { isDuplicate = true }
            }
            if let sectionTwo = (7...13).first(where: { dateBtns[$0].status == true }) {
                if (sectionTwo % 7) == idx { isDuplicate = true }
            }
        default :
            break
        }
        
        if isDuplicate == true {
            dateBtns[index].status = false
            // 알림창 띄우기
            print("중복되었습니다.")
            showToast(message: "요일을 중복되지 않게 선택해주세요!")
        }
    }
    
    /// check()메서드는 모든 요일, 시간 버튼이 클릭될때마다 호출
    private func check() {
        // 섹션 1 검사하는 코드
        // 요일, 시간이 전부 true인지?
        if (0...6).contains(where: { dateBtns[$0].status == true }) && startTimeBtns[0].status && endTimeBtns[0].status {
            // true
            nextBtn.backgroundColor = .main
        } else {
            // false
            nextBtn.backgroundColor = .gray03
            return
        }
        
        if plusBtnCheck[0] == true {
            // 섹션 2 검사하는 코드
            // 요일, 시간이 전부 true인지?
            if (7...13).contains(where: { dateBtns[$0].status == true }) && startTimeBtns[1].status && endTimeBtns[1].status {
                // true
                nextBtn.backgroundColor = .main

            } else {
                // false
                nextBtn.backgroundColor = .gray03
                return
            }
        }

        if plusBtnCheck[1] == true {
            // 섹션 3 검사하는 코드
            // 요일, 시간이 전부 true인지?
            if (14...20).contains(where: { dateBtns[$0].status == true }) && startTimeBtns[2].status && endTimeBtns[2].status {
                // true
                nextBtn.backgroundColor = .main
            } else {
                // false
                nextBtn.backgroundColor = .gray03
                return
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
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        // 취소 버튼 클릭 시, 팝업 창 띄워줌
        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
            dvc.modalPresentationStyle = .overFullScreen
            dvc.modalTransitionStyle = .crossDissolve
            dvc.titleLabel = "작성한 모든 기입정보가 삭제됩니다. \n 크루만들기를 그만두시겠습니까?"
            // 취소버튼 눌렸을 때 효과 나오기위해
            dvc.alertDelegate = self
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            SignUpUserInfo.shared.schedules = []
            // 섹션 0
            for i in 0...6 {
                if dateBtns[i].status == true {
                    guard let date = dateBtns[i].dayId else { return }
                    let start = startTimeBtns[0].stringToDouble()
                    let end = endTimeBtns[0].stringToDouble()
            
                    SignUpUserInfo.shared.schedules?.append(ScheduleList(dayIdx: date, startTime: start, endTime: end))
                }
            }
            // 섹션 1
            for i in 7...13 {
                if plusBtnCheck[0] == true && dateBtns[i].status == true {
                    guard let date = dateBtns[i].dayId else { return }
                    let start = startTimeBtns[1].stringToDouble()
                    let end = endTimeBtns[1].stringToDouble()
                    SignUpUserInfo.shared.schedules?.append(ScheduleList(dayIdx: (date % 7), startTime: start, endTime: end))
                }
            }
            // 섹션 2
            for i in 14...20 {
                if plusBtnCheck[1] == true && dateBtns[i].status == true {
                    guard let date = dateBtns[i].dayId else { return }
                    let start = startTimeBtns[2].stringToDouble()
                    let end = endTimeBtns[2].stringToDouble()
                    SignUpUserInfo.shared.schedules?.append(ScheduleList(dayIdx: (date % 7), startTime: start, endTime: end))
                }
            }
            print("뭐들어와???", SignUpUserInfo.shared.schedules)
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewPhoto", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewPhotoVC") as? MakeCrewPhotoVC {
                self.navigationController?.pushViewController(dvc, animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
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
        if firstBgView.isHidden == true && secondBgView.isHidden == false && nextBtn.backgroundColor == .main {
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
            }
            duplicateCheck(section: 0, index: buttonIndex)
        case 7...13 :
            for i in 7...13 {
                if i != buttonIndex {
                    dateBtns[i].status = false
                }
            }
            duplicateCheck(section: 1, index: buttonIndex)
        case 14...20 :
            for i in 14...20 {
                if i != buttonIndex {
                    dateBtns[i].status = false
                }
            }
            duplicateCheck(section: 2, index: buttonIndex)
        default:
            break
        }
        check()
    }
}

// MARK: - Delegate
// 팝업창 Delegate
extension MakeCrewDateVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 SignInVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let crewVC = viewController as? CrewVC { self.navigationController?.popToViewController(crewVC, animated: true)
                // pop되면서 모든 정보 nil로 초기화
                // SignUpUserInfo.shared.dispose()
            }
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
                btn.status = false
                btn.grayDatePickerBtn()
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
