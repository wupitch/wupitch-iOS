//
//  ProfileVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit
import Alamofire
import SDWebImage

class ProfileVC: BaseVC {

    @IBOutlet weak var myPageLabel: LabelFontSize!
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var profileBgView: UIView!
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var nicknameLabel: LabelFontSize!
    @IBOutlet weak var subLabel: LabelFontSize!
    @IBOutlet weak var profileSettingBtn: UIButton!
    @IBOutlet weak var profileAlertLabel: UILabel!
    @IBOutlet var settingsBtn: [UIButton]!
    @IBOutlet weak var messageModalImageView: UIImageView!
    @IBOutlet weak var alertCancelBtn: UIButton!
    
    lazy var memberInfoDataManager = MemberInfoService()
    let picker = UIImagePickerController()
    var userInfo : MemberInfoResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memberInfoDataManager.getMemberInfo(delegate: self)
    }
    
    private func setStyle() {
        settingsBtn.forEach {
            $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        }
        myPageLabel.titleLabelFontSize()
        profileBgView.makeRounded(cornerRadius: 16)
        profileBgView.layer.borderWidth = 1
        profileBgView.layer.borderColor = UIColor.gray04.cgColor
        nicknameLabel.nicknameLabelFontSize()
        subLabel.CrewNoPlaceLabel()
        profileAlertLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        profileAlertLabel.setTextWithLineHeight(text: profileAlertLabel.text, lineHeight: 20)
        picker.delegate = self
        profileImageVIew.makeRounded(cornerRadius: nil)
    }
    
    // 메시지 취소 버튼
    @IBAction func touchUpMessageCancelBtn(_ sender: Any) {
        messageModalImageView.alpha = 0.0
        profileAlertLabel.alpha = 0.0
        alertCancelBtn.alpha = 0.0
    }
    
    // 알림 버튼
    @IBAction func touchUpAlertBtn(_ sender: Any) {
        // 다음 스토리 보드로 이동
        let storyboard = UIStoryboard.init(name: "CrewAlert", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "CrewAlertVC") as? CrewAlertVC else {return}
        dvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 카메라 버튼
    @IBAction func touchUpCameraBtn(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) {(action) in
            self.openLibrary()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // UIImagePicker
    func openLibrary() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    // 화살표 버튼
    @IBAction func touchUpArrowBtn(_ sender: Any) {
        
        //버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "ProfileDetail", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "ProfileDetailVC") as? ProfileDetailVC else {return}
        dvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 관심 크루 및 번개 버튼
    @IBAction func touchUpPinCrewBungaeBtn(_ sender: Any) {
    }
    
    // 작성글 및 사진
    @IBAction func touchUpPhotoBtn(_ sender: Any) {
    }
    
    // 공지사항 버튼
    @IBAction func touchUpGongJiBtn(_ sender: Any) {
    }
    
    // FAQ 버튼
    @IBAction func touchUpFAQBtn(_ sender: Any) {
        
    }
    
    // 설정 버튼
    @IBAction func touchUpSettingsBtn(_ sender: Any) {
        
        //버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "ProfileSettings", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "ProfileSettingsVC") as? ProfileSettingsVC else {return}
        dvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - UIImagePicker
extension ProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            profileImageVIew.image = image
            
            let url = "https://prod.wupitch.site/app/accounts/image"
            
            var header : HTTPHeaders = []
            
            if let token = UserDefaults.standard.string(forKey: "userToken") {
                header = ["Content-Type":"multipart/form-data", "X-ACCESS-TOKEN": token]
            }
           
            let userImage = self.profileImageVIew.image
            
            AF.upload(
                multipartFormData: { MultipartFormData in
                    if((userImage) != nil){
                        MultipartFormData.append(userImage!.jpegData(compressionQuality: 0.025)!, withName: "images", fileName: "imageNew.jpeg", mimeType: "image/jpeg")
                        print("사진 잘 들어오나 확인 >>>>>", userImage!)
                    }
                }, to: url, method: .post, headers: header).uploadProgress(queue: .main) { progress in
                    
                    print("Upload Progress: \(progress.fractionCompleted)")
                }.responseJSON { data in
                    switch data.result {
                    case .success(let response):
                        print("데이터가 성공적으로 들어왔어요", response)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
        else {
            // 사진 없을 땐 기본 이미지 넣어주기
            profileImageVIew.image = UIImage(named: "profileBasic")
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC {
    func didSuccessMemberInfo(result: MemberInfoResult) {
        print("회원 정보 요청에 성공하셨습니다.")
       
        nicknameLabel.text = result.nickname
        subLabel.text = result.introduce
        
        if result.profileImageURL == nil {
            profileImageVIew.image = UIImage(named: "profileBasic")
        } else {
            profileImageVIew.sd_setImage(with: URL(string: result.profileImageURL ?? ""))
        }
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않습니다.")
    }
}
