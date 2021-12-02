//
//  MakeBungaeDateVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/23.
//

import UIKit

class MakeBungaeDateVC: UIViewController {

    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var toastView: UIView!
    @IBOutlet weak var toastMessageLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet var endTimeBtns: DatePickerBtn!
    @IBOutlet var startTimeBtns: DatePickerBtn!
    @IBOutlet var dateBtns: PickerBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateBtns.pickerDelegate = self
        startTimeBtns.datePickerDelegate = self
        endTimeBtns.datePickerDelegate = self

        toastView.alpha = 0.0
        labelLabel.textColor = .gray02

        titleLabel.makeCrewTitleLabel()
        toastView.makeRounded(cornerRadius: 16.adjusted)
        toastMessageLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
    }

    // 토스트 메시지
    func showToast(message:String) {
        toastMessageLabel.text = message
        self.toastView?.alpha = 1.0
        UIView.animate(withDuration: 4.0, delay: 0.01, animations: {
            self.toastView.alpha = 0.0
        }, completion: nil)
    }
    
    private func check() {
        if dateBtns.status == true {
            // true
            if startTimeBtns.status == true && endTimeBtns.status == true {
                nextBtn.backgroundColor = .main
            }
        } else {
            // false
            nextBtn.backgroundColor = .gray03
            return
        }
        
        if startTimeBtns.status == true && endTimeBtns.status == true {
            // true
            if dateBtns.status == true {
                nextBtn.backgroundColor = .main
            }
        } else {
            // false
            nextBtn.backgroundColor = .gray03
            return
        }
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        // 취소 버튼 클릭 시, 팝업 창 띄워줌
        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
            dvc.modalPresentationStyle = .overFullScreen
            dvc.modalTransitionStyle = .crossDissolve
            dvc.titleLabel = "작성한 모든 기입정보가 삭제됩니다. \n 번개만들기를 그만두시겠습니까?"
            // 취소버튼 눌렸을 때 효과 나오기위해
            dvc.alertDelegate = self
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            // 날짜
            SignUpUserInfo.shared.bungaeDate = dateBtns.titleLabel?.text
            // 시간
            SignUpUserInfo.shared.bungaeStartTime = startTimeBtns.stringToDouble()
            SignUpUserInfo.shared.bungaeEndTime = endTimeBtns.stringToDouble()
            
            print("날짜 및 시간 >>>>>>>>> ", SignUpUserInfo.shared.bungaeDate, SignUpUserInfo.shared.bungaeStartTime, SignUpUserInfo.shared.bungaeEndTime)
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeBungaePhoto", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeBungaePhotoVC") as? MakeBungaePhotoVC {
                self.navigationController?.pushViewController(dvc, animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension MakeBungaeDateVC : DatePickerDelegate {
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
                
            case startTimeBtns :
                if endTimeBtns.status {
                    value = endTimeBtns.doubleDatePicker(secondDate: dateString, location: true)
                }
                
            case endTimeBtns :
                value = startTimeBtns.doubleDatePicker(secondDate: dateString, location: false)
                labelLabel.textColor = .main
                
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

extension MakeBungaeDateVC : PickerDelegate {
    func clickPicker(btn: PickerBtn) {
        let alertVC = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = Locale(identifier: "ko")
        alertVC.view.addSubview(datePicker)
        alertVC.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: alertVC.view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: alertVC.view.trailingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: alertVC.view.topAnchor, constant: 10).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: alertVC.view.bottomAnchor, constant: -120).isActive = true
        
        let okAction = UIAlertAction(title: "확인", style: .default) { [self] _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePicker.date)
            var value = true
            
            if value == false {
                print("벨류가 펄스다")
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

// MARK: - Delegate
// 팝업창 Delegate
extension MakeBungaeDateVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 SignInVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let bungaeVC = viewController as? BungaeVC { self.navigationController?.popToViewController(bungaeVC, animated: true)
                // pop되면서 모든 정보 nil로 초기화
                // SignUpUserInfo.shared.dispose()
            }
        }
    }
}
