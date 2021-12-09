//
//  MakceCrewGuestVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/08.
//

import UIKit
import Alamofire

protocol CrewDelegate {
    func makeCrewToPopPresentPage()
}

class MakeCrewGuestVC: UIViewController {
    
    @IBOutlet weak var guestSubTitleLabel: UILabel!
    @IBOutlet weak var guestTitleLabel: UILabel!
    @IBOutlet weak var guestView: UIView!
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var noMoneyLabelBtn: CheckBtn!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleLabel: LabelFontSize!
    
    var crewDelegate : CrewDelegate?
    lazy var makeCrewDataManager = MakeCrewService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        titleTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        titleTextField.resignFirstResponder()
    }
    
    private func setStyle() {
        titleLabel.makeCrewTitleLabel()
        titleTextField.delegate = self
        titleTextField.backgroundColor = .gray05
        titleTextField.borderStyle = .none
        titleTextField.makeRounded(cornerRadius: 8.adjusted)
        titleTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        titleTextField.textColor = .gray03
        titleTextField.addLeftPadding()
        
        noMoneyLabelBtn.setTitleColor(.gray02, for: .normal)
        noMoneyLabelBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        noMoneyLabelBtn.titleLabel?.setTextWithLineHeight(text: noMoneyLabelBtn.titleLabel?.text, lineHeight: 19.adjusted)
        
        noMoneyLabelBtn.grayCheck()
        
        guestView.makeRounded(cornerRadius: 16.adjusted)
        guestTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        guestTitleLabel.textColor = .main
        guestSubTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        guestSubTitleLabel.textColor = .main
        
    }
    
    @IBAction func touchUpGuestBtn(_ sender: Any) {
        if noMoneyLabelBtn.status == false {
            noMoneyLabelBtn.colorCheck()
            titleTextField.isEnabled = false
            titleTextField.text = nil
            nextBtn.backgroundColor = .main
        }
        else {
            noMoneyLabelBtn.grayCheck()
            titleTextField.isEnabled = true
            nextBtn.backgroundColor = .gray03
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
    
    // 게시하기 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            
            SignUpUserInfo.shared.guestMoney = Int(titleTextField.text ?? "") ?? nil
            print("손님비 >>>>>>>>>>>", SignUpUserInfo.shared.guestMoney)

            makeCrewDataManager.postMakeCrew(MakeCrewRequest(ageList: SignUpUserInfo.shared.ageList ?? [], areaID: SignUpUserInfo.shared.selectAreaPicker ?? -99, conference: SignUpUserInfo.shared.money ?? 0, extraInfoList: SignUpUserInfo.shared.extraInfoList ?? [], guestConference: SignUpUserInfo.shared.guestMoney ?? 0, inquiries: SignUpUserInfo.shared.question ?? "", introduction: SignUpUserInfo.shared.crewInfo ?? "", location: SignUpUserInfo.shared.location ?? "장소미정", sportsID: SignUpUserInfo.shared.clickSportsBtn ?? -99, title: SignUpUserInfo.shared.title ?? "", memberCount: SignUpUserInfo.shared.crewCount ?? -99, materials: SignUpUserInfo.shared.materials ?? "준비물이 없어요.", scheduleList: SignUpUserInfo.shared.schedules ?? []), delegate: self)
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
}

extension MakeCrewGuestVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleTextField.textColor = .bk
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if titleTextField.text?.isEmpty == false {
            nextBtn.backgroundColor = .main
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if titleTextField.isEditing == true {
            let currentCharacterCount = textField.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            
            return newLength <= 6
        }
        return true
    }
}

// MARK: - 크루 생성 api
extension MakeCrewGuestVC {
    func didSuccessMakeCrew(result: MakeCrewResult) {
        print("요청에 성공하셨습니다.")
        print("클럽 아이디",result.clubID)
        
        let url = "https://prod.wupitch.site/app/clubs/image"
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"multipart/form-data", "X-ACCESS-TOKEN": token]
        }
        let crewId = String(result.clubID)
        
        // 크루아이디 저장
        UserDefaults.standard.set(result.clubID, forKey: "clubID")
        
        let userImage = SignUpUserInfo.shared.photo
        
        AF.upload(
            multipartFormData: { MultipartFormData in
                
                if((userImage) != nil) {
                    MultipartFormData.append(userImage!.jpegData(compressionQuality: 0.025)! ,withName: "images", fileName: "imageNew.jpeg", mimeType: "image/jpeg")
                    print("사진 잘 들어오나 확인 >>>>>", userImage!)
                    MultipartFormData.append(Data(crewId.utf8), withName: "crewId")
                }
            }, to: url, method: .patch, headers: header).uploadProgress(queue: .main) { progress in
                
                print("Upload Progress: \(progress.fractionCompleted)")
            }.responseJSON { data in
                switch data.result {
                case .success(let response):
                    print("데이터가 성공적으로 들어왔어요", response)
                    
                    guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                    // 뷰 스택에서 crewVC를 찾아서 거기까지 pop 합니다. 후에 crewDetailVC를 찾아서 push 합니다.
                    for viewController in viewControllerStack {
                        if let crewVC = viewController as? CrewVC {
                            self.navigationController?.popToViewController(crewVC, animated: true)
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "CrewDetail", bundle: nil)
                            if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewDetailVC") as? CrewDetailVC {
                                dvc.hidesBottomBarWhenPushed = true
                                self.navigationController?.pushViewController(dvc, animated: true)
                            }
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않습니다.")
    }
}

// MARK: - Delegate
// 팝업창 Delegate
extension MakeCrewGuestVC : AlertDelegate {
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
