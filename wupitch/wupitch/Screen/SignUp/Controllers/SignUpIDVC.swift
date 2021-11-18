//
//  SignUpFifthVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/21.
//

import UIKit

// 신분증 인증 뷰
class SignUpIDVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - IBoutlets
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var thirdContentsLabel: UILabel!
    @IBOutlet weak var secondContentsLabel: UILabel!
    @IBOutlet weak var firstContentsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoBtn: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    private func setStyle() {
        // title Label
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        titleLabel.textColor = .black
        
        // description Label
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 20.adjusted)
        descriptionLabel.textColor = .gray02
        
        // photo Btn
        photoBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        photoBtn.makeRounded(cornerRadius: 8.adjusted)
        
        // Label
        firstContentsLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        secondContentsLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        thirdContentsLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
    }
    
    // MARK: - IBActions
    // 취소버튼
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
    
    // 뒤로가기 버튼
    @IBAction func touchUpBackbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 신분증 인증 버튼
    @IBAction func touchUpPhotoBtn(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "SignUpCamera", bundle: nil)
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpCameraVC") as? SignUpCameraVC else {return}
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - delegate
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
