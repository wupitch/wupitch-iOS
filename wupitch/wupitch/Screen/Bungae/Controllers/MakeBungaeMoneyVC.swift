//
//  MakeBungaeMoneyVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/23.
//

import UIKit
import Alamofire

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
            SignUpUserInfo.shared.bungaeDues = Int(titleTextField.text ?? "") ?? nil
            print("참여비 >>>>>>>>>>>>>",SignUpUserInfo.shared.bungaeDues)
            
            makeBungaeDataManager.postMakeBungae(MakeBungaeRequest(areaID: SignUpUserInfo.shared.bungaeSelectAreaId ?? -99, location: SignUpUserInfo.shared.bungaeLocation ?? "", date: SignUpUserInfo.shared.bungaeDate ?? "", startTime: SignUpUserInfo.shared.bungaeStartTime ?? 0.0, endTime: SignUpUserInfo.shared.bungaeEndTime ?? 0.0, title: SignUpUserInfo.shared.bungaeTitle ?? "", introduction: SignUpUserInfo.shared.bungaeIntroduction ?? "", inquiries: SignUpUserInfo.shared.bungaeInquiries ?? "", materials: SignUpUserInfo.shared.bungaeMaterials ?? "준비물이 없어요.", recruitmentCount: SignUpUserInfo.shared.bungaeCount ?? -99, dues: SignUpUserInfo.shared.bungaeDues ?? 0), delegate: self)
            
            print("제대로 나오나 확인", SignUpUserInfo.shared.bungaeSelectAreaId ?? -99, SignUpUserInfo.shared.bungaeLocation ?? "장소미정", SignUpUserInfo.shared.bungaeDate ?? "", SignUpUserInfo.shared.bungaeStartTime ?? 0.0, SignUpUserInfo.shared.bungaeEndTime ?? 0.0, SignUpUserInfo.shared.bungaeTitle ?? "", SignUpUserInfo.shared.bungaeIntroduction ?? "", SignUpUserInfo.shared.bungaeInquiries ?? "", SignUpUserInfo.shared.bungaeMaterials ?? "", SignUpUserInfo.shared.bungaeCount ?? -99, SignUpUserInfo.shared.bungaeDues ?? 0 )
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
        print("번개 아이디",result.impromptuID)

        let url = "https://dev.yogiyo-backend.shop/app/impromptu/image"
        //let url = "https://prod.wupitch.site/app/impromptu/image"

        var header : HTTPHeaders = []

        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"multipart/form-data", "X-ACCESS-TOKEN": token]
        }
        let impromptuId = String(result.impromptuID)

        let userImage = SignUpUserInfo.shared.bungaePhoto
        
        UserDefaults.standard.set(result.impromptuID, forKey: "impromptuID")

        AF.upload(
            multipartFormData: { MultipartFormData in

                if((userImage) != nil) {
                    MultipartFormData.append(userImage!.jpegData(compressionQuality: 0.025)! ,withName: "images", fileName: "imageNew.jpeg", mimeType: "image/jpeg")
                    print("사진 잘 들어오나 확인 >>>>>", userImage!)
                    MultipartFormData.append(Data(impromptuId.utf8), withName: "impromptuId")
                }
            }, to: url, method: .patch, headers: header).uploadProgress(queue: .main) { progress in

                print("Upload Progress: \(progress.fractionCompleted)")
            }.responseJSON { data in
                switch data.result {
                case .success(let response):
                    print("데이터가 성공적으로 들어왔어요", response)

                    guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                    // 뷰 스택에서 crewVC를 찾아서 거기까지 pop 합니다. 후에 bungaeDetailVC를 찾아서 push 합니다.
                    for viewController in viewControllerStack {
                        if let bungaeVC = viewController as? BungaeVC {
                            self.navigationController?.popToViewController(bungaeVC, animated: true)

                            let storyBoard: UIStoryboard = UIStoryboard(name: "BungaeDetail", bundle: nil)
                            if let dvc = storyBoard.instantiateViewController(withIdentifier: "BungaeDetailVC") as? BungaeDetailVC {
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
extension MakeBungaeMoneyVC : AlertDelegate {
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
