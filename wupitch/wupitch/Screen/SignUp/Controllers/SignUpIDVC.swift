//
//  SignUpFifthVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

class SignUpIDVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var thirdContentsLabel: UILabel!
    @IBOutlet weak var secondContentsLabel: UILabel!
    @IBOutlet weak var firstContentsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoBtn: UIButton!
    
    let overlayView = UIImageView(image:UIImage(named: "default"))
    var cameraView = UIView()
//    var screenBounds: CGSize = UIScreen.screens.bounds.size;

    
    
//    private lazy var imagePickerController: UIImagePickerController = {
//        let imagePicker = UIImagePickerController()
//
//
//        imagePicker.sourceType = .camera
//               imagePicker.allowsEditing = false
//               imagePicker.cameraDevice = .rear
//               imagePicker.cameraCaptureMode = .photo
//
//               let imgView = UIImageView(frame: CGRect(x: 43, y: 259, width: 290, height: 190))
//               imgView.image = UIImage(named: "imgGl")
//               imagePicker.cameraOverlayView = imgView
//               imagePicker.showsCameraControls = true
//
//               cameraView = UIView(frame: CGRect(x: 50, y: 300, width: 200, height: 200))
//        cameraView.backgroundColor = UIColor.black
//               imagePicker.view.frame = cameraView.bounds
//
//               imagePicker.delegate = self
//
//        var scale = screenBounds.height / screenBounds.width;
//
//        imagePicker.cameraViewTransform = CGAffineTransform(scaleX: scale, y: scale)
//
//            present(imagePicker, animated: true, completion: nil)
//
//
//
//        return imagePicker
//        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // addCameraInView()
        setStyle()
    }
    func setStyle() {
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        titleLabel.textColor = .black
        
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 20.adjusted)
        descriptionLabel.textColor = .gray02
        
        photoBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        photoBtn.makeRounded(cornerRadius: 8.adjusted)
        
        firstContentsLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        secondContentsLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        thirdContentsLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
    }
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        // 취소 버튼 클릭 시, 팝업 창 띄워줌
        let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
        
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
            dvc.modalPresentationStyle = .overFullScreen
            dvc.modalTransitionStyle = .crossDissolve
            
            dvc.alertDelegate = self
            
            // present 형태로 띄우기
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    @IBAction func touchUpBackbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpPhotoBtn(_ sender: Any) {
        
        //self.cameraView.addSubview((imagePickerController.view))
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.cameraDevice = .rear
        imagePicker.cameraCaptureMode = .photo

        let imgView = UIImageView(frame: CGRect(x: 43, y: 259, width: 290, height: 190))
        imgView.image = UIImage(named: "imgGl")
        imagePicker.cameraOverlayView = imgView
        imagePicker.showsCameraControls = true

//        cameraView = UIView(frame: CGRect(x: 50, y: 300, width: 300, height: 300))
//        cameraView.backgroundColor = .black
//        imagePicker.view.frame = cameraView.bounds

        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)

        let camera = UIImagePickerController()
        camera.sourceType = .camera
        camera.allowsEditing = true
        camera.cameraDevice = .rear
        camera.cameraOverlayView = overlayView
        camera.cameraCaptureMode = .photo
        camera.delegate = self
        present(camera, animated: true, completion: nil)
    }
    
//    private func addCameraInView(){
//         // Add the imageviewcontroller to UIView as a subview
//         self.cameraView.addSubview((imagePickerController.view))
//     }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            
            SignUpUserInfo.shared.idImg = image
            //myImageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
        
        if SignUpUserInfo.shared.idImg != nil {
            let storyboard = UIStoryboard.init(name: "SignUpComplete", bundle: nil)
            
            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpCompleteVC") as? SignUpCompleteVC else {return}
            
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpIDVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 SignInVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let signInVC = viewController as? SignInVC { self.navigationController?.popToViewController(signInVC, animated: true)
                // pop되면서 모든 정보 nil로 초기화
                SignUpUserInfo.shared.dispose()
            }
        }
    }
}
