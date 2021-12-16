//
//  SignUpImagePreviewVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/17.
//

import UIKit
import Alamofire

class SignUpImagePreviewVC: UIViewController {

    @IBOutlet weak var imagePrevieImageView: UIImageView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var usePhotoBtn: UIButton!
    @IBOutlet weak var cameraAgainBtn: UIButton!
    public var image: UIImage?
    
    lazy var signUpManager = SignUpService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cameraAgainBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        usePhotoBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let img = self.image {
            self.imagePrevieImageView?.image = img
        }
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        // 뷰 스택에서 SignUpCameraVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let signUpIDVC = viewController as? SignUpIDVC { self.navigationController?.popToViewController(signUpIDVC, animated: true)
            }
        }
    }

    @IBAction func touchUpCameraAgainBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpUsePhotoBtn(_ sender: Any) {
        
        let url = "https://dev.yogiyo-backend.shop/app/accounts/identification"
        //let url = "https://prod.wupitch.site/app/accounts/identification"
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"multipart/form-data", "X-ACCESS-TOKEN": token]
        }
        
        let userImage = self.imagePrevieImageView?.image
        
        AF.upload(
            multipartFormData: { MultipartFormData in
                if((userImage) != nil){
                    MultipartFormData.append(userImage!.jpegData(compressionQuality: 0.025)!, withName: "images", fileName: "imageNew.jpeg", mimeType: "image/jpeg")
                    print("사진 잘 들어오나 확인 >>>>>", userImage!)
                }
            }, to: url, method: .post, headers: header).uploadProgress(queue: .main) { progress in
                
                print("Upload Progress: \(progress.fractionCompleted)")
            }.responseJSON { [self] data in
                switch data.result {
                case .success(let response):
                    print("데이터가 성공적으로 들어왔어요", response)
                    
                    // 신분증 인증 전의 회원가입 데이터들을 한번에 보내기
                    if let email = UserDefaults.standard.string(forKey: "email"),
                       let introduce = UserDefaults.standard.string(forKey: "introduce"),
                       let isPushAgree = SignUpUserInfo.shared.isPushAgree,
                       let nickname = SignUpUserInfo.shared.nickname,
                       let password = SignUpUserInfo.shared.password,
                       let deviceToken = UserDefaults.standard.string(forKey: "deviceToken") {
                        
                        signUpManager.postSignUp(SignUpRequest(email: email, introduce: introduce, isPushAgree: isPushAgree, nickname: nickname, password: password, deviceToken: deviceToken), delegate: self)
                    
                     print("디바이스토큰 >>>>>>>>>",UserDefaults.standard.string(forKey: "deviceToken"))
                    //버튼 클릭 시, 다음 스토리보드로 이동
                    let storyboard = UIStoryboard.init(name: "SignUpComplete", bundle: nil)
                    guard let dvc = storyboard.instantiateViewController(identifier: "SignUpCompleteVC") as? SignUpCompleteVC else {return}
                        self.navigationController?.pushViewController(dvc, animated: true)
                    }
                    print("나와안나와...")
                    print("이메일",SignUpUserInfo.shared.email ?? "이메일이 없습니다.")
                    print("자기소개유저디폴트",UserDefaults.standard.string(forKey: "introduce") ?? "자기소개가 없습니다.")
                    print("자기소개", SignUpUserInfo.shared.introduce ?? "자기소개가없습니다.")
                    print("푸시알림동의",SignUpUserInfo.shared.isPushAgree ?? "푸시알림동의가없습니다.")
                    print("닉네임",SignUpUserInfo.shared.nickname ?? "닉네임이 없습니다.")
                    print("비밀번호",SignUpUserInfo.shared.password ?? "비밀번호가 없습니다,")
                    print("디바이스토큰",UserDefaults.standard.string(forKey: "deviceToken") ?? "디바이스 토큰이 없습니다.")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image {
            context in self.draw(in: CGRect(origin: .zero, size: size)) }
        print("화면 배율: \(UIScreen.main.scale)") // 배수
        print("origin: \(self), resize: \(renderImage)")
        return renderImage
    }
}

// 회원가입 api
extension SignUpImagePreviewVC {
    // 다음 버튼 누르면 값을 한번에 넣어주자!
    func didSuccessSignUp(result: SignUpResult) {
        print("회원가입 데이터가 성공적으로 들어왔습니다.")
        // 자동로그인을 위해 유저디폴트에 유저 토큰 저장
        UserDefaults.standard.set(result.jwt, forKey: "userToken")
        // 혹시모르니 유저 아이디도 저장
        UserDefaults.standard.set(result.accountID, forKey: "userID")
    }
    
    func failedToRequest(message: String) {
        print("회원가입 데이터가 들어오지 않았습니다.")
        UserDefaults.standard.removeObject(forKey: "userToken")
        UserDefaults.standard.removeObject(forKey: "userID")
        
    }
}


