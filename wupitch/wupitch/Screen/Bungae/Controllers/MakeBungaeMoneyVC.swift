//
//  MakeBungaeMoneyVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/23.
//

import UIKit

class MakeBungaeMoneyVC: UIViewController {

    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var noMoneyLabel: CheckBtn!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var titleLabel: LabelFontSize!
    
    lazy var makeBungaeDataManager = MakeBungaeService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        addDoneButtonOnKeyboard()
    }

    private func setStyle() {
        oneLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        oneLabel.textColor = .bk
        titleLabel.makeCrewTitleLabel()
        titleTextField.delegate = self
        titleTextField.backgroundColor = .gray05
        titleTextField.borderStyle = .none
        titleTextField.makeRounded(cornerRadius: 8.adjusted)
        titleTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        titleTextField.textColor = .gray03
        titleTextField.addLeftPadding()
        
        noMoneyLabel.setTitleColor(.gray02, for: .normal)
        noMoneyLabel.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        noMoneyLabel.titleLabel?.setTextWithLineHeight(text: noMoneyLabel.titleLabel?.text, lineHeight: 19.adjusted)
        
        noMoneyLabel.grayCheck()
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
    
    
    @IBAction func touchUpNoMoneyBtn(_ sender: Any) {
        if noMoneyLabel.status == false {
            noMoneyLabel.colorCheck()
            titleTextField.isEnabled = false
            titleTextField.text = nil
            nextBtn.backgroundColor = .main
        }
        else {
            noMoneyLabel.grayCheck()
            titleTextField.isEnabled = true
            nextBtn.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            SignUpUserInfo.shared.bungaeDues = Int(titleTextField.text ?? "") ?? nil
            print("참여비 >>>>>>>>>>>>>",SignUpUserInfo.shared.bungaeDues)
            
            makeBungaeDataManager.postMakeBungae(MakeBungaeRequest(areaID: SignUpUserInfo.shared.bungaeSelectAreaId ?? -99, location: SignUpUserInfo.shared.bungaeLocation ?? "", date: SignUpUserInfo.shared.bungaeDate ?? "", startTime: SignUpUserInfo.shared.bungaeStartTime ?? 0.0, endTime: SignUpUserInfo.shared.bungaeEndTime ?? 0.0, title: SignUpUserInfo.shared.bungaeTitle ?? "", introduction: SignUpUserInfo.shared.bungaeIntroduction ?? "", inquiries: SignUpUserInfo.shared.bungaeInquiries ?? "", materials: SignUpUserInfo.shared.bungaeMaterials ?? "", recruitmentCount: SignUpUserInfo.shared.bungaeCount ?? -99, dues: SignUpUserInfo.shared.bungaeDues ?? -99), delegate: self)
            
            print("제대로 나오나 확인", SignUpUserInfo.shared.bungaeSelectAreaId ?? -99, SignUpUserInfo.shared.bungaeLocation ?? "", SignUpUserInfo.shared.bungaeDate ?? "", SignUpUserInfo.shared.bungaeStartTime ?? 0.0, SignUpUserInfo.shared.bungaeEndTime ?? 0.0, SignUpUserInfo.shared.bungaeTitle ?? "", SignUpUserInfo.shared.bungaeIntroduction ?? "", SignUpUserInfo.shared.bungaeInquiries ?? "", SignUpUserInfo.shared.bungaeMaterials ?? "", SignUpUserInfo.shared.bungaeCount ?? -99, SignUpUserInfo.shared.bungaeDues ?? -99 )
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }

}

extension MakeBungaeMoneyVC : UITextFieldDelegate {
    
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
        
        // 6자리로 막아놓기
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

// MARK: - 번개 생성 api
extension MakeBungaeMoneyVC {
    func didSuccessMakeBungae(result: MakeBungaeResult) {
        print("요청에 성공하셨습니다.")
        print(result.impromptuID)
    }
//        let url = "https://prod.wupitch.site/app/clubs/image"
//
//        var header : HTTPHeaders = []
//
//        if let token = UserDefaults.standard.string(forKey: "userToken") {
//            header = ["Content-Type":"multipart/form-data", "X-ACCESS-TOKEN": token]
//        }
//        let crewId = String(result.clubID)
//
//        let userImage = SignUpUserInfo.shared.photo
//
//        AF.upload(
//            multipartFormData: { MultipartFormData in
//
//                if((userImage) != nil) {
//                    MultipartFormData.append(userImage!.jpegData(compressionQuality: 0.025)! ,withName: "images", fileName: "imageNew.jpeg", mimeType: "image/jpeg")
//                    print("사진 잘 들어오나 확인 >>>>>", userImage!)
//                    MultipartFormData.append(Data(crewId.utf8), withName: "crewId")
//                }
//            }, to: url, method: .patch, headers: header).uploadProgress(queue: .main) { progress in
//
//                print("Upload Progress: \(progress.fractionCompleted)")
//            }.responseJSON { data in
//                switch data.result {
//                case .success(let response):
//                    print("데이터가 성공적으로 들어왔어요", response)
//
//                    guard let viewControllerStack = self.navigationController?.viewControllers else { return }
//                    // 뷰 스택에서 crewVC를 찾아서 거기까지 pop 합니다. 후에 crewDetailVC를 찾아서 push 합니다.
//                    for viewController in viewControllerStack {
//                        if let crewVC = viewController as? CrewVC {
//                            self.tabBarController?.tabBar.isHidden = false
//                            self.navigationController?.popToViewController(crewVC, animated: true)
//
//                            let storyBoard: UIStoryboard = UIStoryboard(name: "CrewDetail", bundle: nil)
//                            if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewDetailVC") as? CrewDetailVC {
//                                self.navigationController?.pushViewController(dvc, animated: true)
//                            }
//                        }
//                    }
//
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않습니다.")
    }
}
