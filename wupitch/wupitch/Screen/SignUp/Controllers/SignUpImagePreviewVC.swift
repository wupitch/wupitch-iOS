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
    
    //lazy var profileImageDataManager = ProfileImageService()
    
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
        
        let url = "https://prod.wupitch.site/app/accounts/image"
        
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
            }.responseJSON { data in
                switch data.result {
                case .success(let response):
                    print("데이터가 성공적으로 들어왔어요", response)
                    
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
