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
        
        
//        if let sportsBtn = SignUpUserInfo.shared.clickSportsBtn,
//           let areaId = SignUpUserInfo.shared.selectAreaPicker,
//           let location = SignUpUserInfo.shared.location,
//           //let crewName = SignUpUserInfo.shared.crewName,
//           let crewCount = SignUpUserInfo.shared.crewCount,
//           let ageList = SignUpUserInfo.shared.ageList,
//           let extraInfoList = SignUpUserInfo.shared.extraInfoList,
//           let schedules = SignUpUserInfo.shared.schedules,
//           let title = SignUpUserInfo.shared.title,
//           let crewInfo = SignUpUserInfo.shared.crewInfo,
//           let materials = SignUpUserInfo.shared.materials,
//           let question = SignUpUserInfo.shared.question,
//           let money = SignUpUserInfo.shared.money,
//           let guestMoney = SignUpUserInfo.shared.guestMoney {
//
//            makeCrewDataManager.postMakeCrew(MakeCrewRequest(ageList: ageList, areaID: areaId, conference: money, extraInfoList: extraInfoList, guestConference: guestMoney, inquiries: question, introduction: crewInfo, location: location, sportsID: sportsBtn, title: title, memberCount: crewCount, materials: materials, scheduleList: schedules), delegate: self)
//        }
//        else {
//            print("rkqtdjqtdma")
//        }
        
        
        setStyle()
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
        
    }
    
    // 게시하기 버튼
    @IBAction func touchUpNextBtn(_ sender: Any) {
        if nextBtn.backgroundColor == .main {
            
            SignUpUserInfo.shared.guestMoney = Int(titleTextField.text ?? "") ?? nil
            print("손님비 >>>>>>>>>>>", SignUpUserInfo.shared.guestMoney)
            
            makeCrewDataManager.postMakeCrew(MakeCrewRequest(ageList: SignUpUserInfo.shared.ageList ?? [], areaID: SignUpUserInfo.shared.selectAreaPicker ?? -99, conference: SignUpUserInfo.shared.money ?? -99, extraInfoList: SignUpUserInfo.shared.extraInfoList ?? [], guestConference: SignUpUserInfo.shared.guestMoney ?? -99, inquiries: SignUpUserInfo.shared.question ?? "", introduction: SignUpUserInfo.shared.crewInfo ?? "", location: SignUpUserInfo.shared.location ?? "", sportsID: SignUpUserInfo.shared.clickSportsBtn ?? -99, title: SignUpUserInfo.shared.title ?? "", memberCount: SignUpUserInfo.shared.crewCount ?? -99, materials: SignUpUserInfo.shared.materials ?? "", scheduleList: SignUpUserInfo.shared.schedules ?? []), delegate: self)
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
        print(result.clubID)
        
        let url = "https://prod.wupitch.site/app/clubs/image"
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"multipart/form-data", "X-ACCESS-TOKEN": token]
        }
        let crewId = String(result.clubID)
        
        // 크루아이디 저장
        UserDefaults.standard.set(result.clubID, forKey: "clubId")
        
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
