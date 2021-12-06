//
//  MakeCrewInfoVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit

class MakeCrewInfoVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet var addInfoBtns: [SportsBtn]!
    @IBOutlet var ageBtns: [SportsBtn]!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var crewCountTextField: UITextField!
    @IBOutlet weak var crewNameTextField: UITextField!
    @IBOutlet weak var addSubTitleLabel: LabelFontSize!
    @IBOutlet weak var subTitleLabel: LabelFontSize!
    @IBOutlet weak var addInfoLabel: LabelFontSize!
    @IBOutlet weak var ageLabel: LabelFontSize!
    @IBOutlet weak var crewCountLabel: LabelFontSize!
    @IBOutlet weak var crewNameLabel: LabelFontSize!
    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var makeCrewLabel: LabelFontSize!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: NextBtn!
    
    lazy var extraDataManager = ExtraService()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        addDoneButtonOnKeyboard()
        extraDataManager.getExtra(delegate: self)
    }
    
    // MARK: - Function
    private func setStyle() {
        // titleLabel Style
        titleLabel.makeCrewTitleLabel()
        // subTitleStyle
        subTitleLabel.makeCrewSubTitleLabel()
        addSubTitleLabel.makeCrewSubTitleLabel()
        
        crewNameTextField.backgroundColor = .gray05
        crewNameTextField.borderStyle = .none
        crewNameTextField.makeRounded(cornerRadius: 8.adjusted)
        crewNameTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        crewNameTextField.textColor = .gray03
        crewNameTextField.addLeftPadding()
        crewNameTextField.delegate = self
        
        crewCountTextField.backgroundColor = .gray05
        crewCountTextField.borderStyle = .none
        crewCountTextField.makeRounded(cornerRadius: 8.adjusted)
        crewCountTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        crewCountTextField.textColor = .gray03
        crewCountTextField.addLeftPadding()
        crewCountTextField.delegate = self
        
        // 추가정보 중복 선택 가능
        for i in 0...7 {
            addInfoBtns[i].graySportsBtn()
        }
        
        // 연령대 싱글톤 값으로 초기화
        for i in 0...4 {
            ageBtns[i].ageInt = i
        }
    }
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

        crewCountTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            crewCountTextField.resignFirstResponder()
        }

    // MARK: - IBAction
    @IBAction func touchUpFirstBtn(_ sender: Any) {
        if ageBtns[0].backgroundColor == .gray04 {
            ageBtns[0].colorSportsBtn()
            if crewNameTextField.text?.isEmpty == false && crewCountTextField.text?.isEmpty == false {
                nextBtn.backgroundColor = .main
            }
        }
        else {
            ageBtns[0].defaultSportsBtn()
            if ageBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }

    @IBAction func touchUpSecondBtn(_ sender: Any) {
        if ageBtns[1].backgroundColor == .gray04 {
            ageBtns[1].colorSportsBtn()
            if crewNameTextField.text?.isEmpty == false && crewCountTextField.text?.isEmpty == false {
                nextBtn.backgroundColor = .main
            }
        }
        else {
            ageBtns[1].defaultSportsBtn()
            if ageBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }

    @IBAction func touchUpThirdBtn(_ sender: Any) {
        if ageBtns[2].backgroundColor == .gray04 {
            ageBtns[2].colorSportsBtn()
            if crewNameTextField.text?.isEmpty == false && crewCountTextField.text?.isEmpty == false {
                nextBtn.backgroundColor = .main
            }
        }
        else {
            ageBtns[2].defaultSportsBtn()
            if ageBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }

    @IBAction func touchUpFourthBtn(_ sender: Any) {
        if ageBtns[3].backgroundColor == .gray04 {
            ageBtns[3].colorSportsBtn()
            if crewNameTextField.text?.isEmpty == false && crewCountTextField.text?.isEmpty == false {
                nextBtn.backgroundColor = .main
            }
        }
        else {
            ageBtns[3].defaultSportsBtn()
            if ageBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }

    @IBAction func touchUpFifthBtn(_ sender: Any) {
        if ageBtns[4].backgroundColor == .gray04 {
            ageBtns[4].colorSportsBtn()
            if crewNameTextField.text?.isEmpty == false && crewCountTextField.text?.isEmpty == false {
                nextBtn.backgroundColor = .main
            }
        }
        else {
            ageBtns[4].defaultSportsBtn()
            if ageBtns.filter({$0.status}).count < 1 {
                nextBtn.backgroundColor = .gray03
            }
        }
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
    
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            // 나이버튼 활성화 상태 확인 후
            // 나이버튼의 인티저 값을 agelist에 넣어줌
            SignUpUserInfo.shared.ageList = []
            SignUpUserInfo.shared.extraInfoList = []
            for i in 0...4 {
                if ageBtns[i].status == true {
                    SignUpUserInfo.shared.ageList?.append(ageBtns[i].ageInt!)
                    print("연령대 >>>>>>>>>",SignUpUserInfo.shared.ageList)
                }
            }
            for i in 0...7 {
                if addInfoBtns[i].status == true {
                    SignUpUserInfo.shared.extraInfoList?.append(addInfoBtns[i].extraId!)
                    print("추가정보 >>>>>>>>>",SignUpUserInfo.shared.extraInfoList)
                }
            }
            // 싱글톤에 값 넣어주기
            SignUpUserInfo.shared.crewName = crewNameTextField.text
            SignUpUserInfo.shared.crewCount = Int(crewCountTextField.text ?? "") ?? 0
            print("크루이름 >>>>>>>>>",SignUpUserInfo.shared.crewName ?? "크루이름이 없습니다.")
            print("현재 크루원 수 >>>>>>>>>",SignUpUserInfo.shared.crewCount ?? "현재 크루원 수가 없습니다.")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "MakeCrewDate", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "MakeCrewDateVC") as? MakeCrewDateVC {
                navigationController?.pushViewController(dvc, animated: true)
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

// MARK: -  Extension
extension MakeCrewInfoVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        crewNameTextField.textColor = .bk
        crewCountTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if crewNameTextField.text?.isEmpty == false && crewCountTextField.text?.isEmpty == false {
            for i in 0...4 {
                if ageBtns[i].status == true {
                    nextBtn.backgroundColor = .main
                }
            }
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        crewNameTextField.resignFirstResponder()
        crewCountTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if crewCountTextField.isEditing == true {
            let currentCharacterCount = textField.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            
            return newLength <= 3
        }
        return true
    }
}

// MARK: - Delegate
// 팝업창 Delegate
extension MakeCrewInfoVC : AlertDelegate {
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

extension MakeCrewInfoVC {
    func didSuccessExtra(result: [ExtraResult]) {
        print("값이 성공적으로 들어왔습니다.")
        
        // 추가정보 싱글톤에 버튼 아이디 값 넣어주기 (싱글톤에 저장)
        // 버튼 자체에 싱글톤 값 넣어주기
        SignUpUserInfo.shared.extraInfo = []
        for i in 0...7 {
            SignUpUserInfo.shared.extraInfo?.append(result[i].extraID)
            addInfoBtns[i].extraId = result[i].extraID
            print(">>>", addInfoBtns[i].extraId ?? "값이 없어용")
        }
    }
    
    func failedToRequest(message: String) {
        print("값이 들어오지 않았습니다.")
    }
}
