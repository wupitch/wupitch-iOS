//
//  JoinAlertVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/26.
//

// 해야할 것
// 1. 팝업창에서 '그만둘래요' 누르면 싱글톤에 있는 데이터 싹 없애주기

protocol AlertDelegate {
    func alertDismiss()
}

import UIKit

class JoinAlertVC: UIViewController {
    
    var alertDelegate : AlertDelegate?

    // MARK: - IBOulets
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

       setStyle()
        
    }
    
    // MARK: - Function
    // style
    func setStyle() {
        // popupView Style
        popUpView.layer.cornerRadius = 16.adjusted
        
        // stopBtn style
        stopBtn.layer.cornerRadius = 8.adjusted
        stopBtn.layer.borderWidth = 1.adjusted
        stopBtn.layer.borderColor = UIColor.gray03.cgColor
        
        // continueBtn Style
        continueBtn.layer.cornerRadius = 8.adjusted
    }
    
    // MARK: - IBActions
    // 엑스 버튼
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 그만둘래요 버튼
    @IBAction func touchUpStopBtn(_ sender: Any) {
        // 온보딩 4로
        // 디스미스 후에 팝 루트 뷰 컨트롤러로 가게
        alertDelegate?.alertDismiss()
        self.dismiss(animated: true, completion: nil)
        
//        let storyboard = UIStoryboard.init(name: "Onboarding", bundle: nil)
//
//        guard let dvc = storyboard.instantiateViewController(identifier: "OnbordingVC") as? OnbordingVC else {return}
//
//        navigationController?.popViewController(animated: true)
        
//        let storyboard = UIStoryboard.init(name: "Onboarding", bundle: nil)
//        guard let dvc = storyboard.instantiateViewController(identifier: "OnboardingNC") as? OnboardingNC else {return}
//
//        //guard let viewControllerStack = self.navigationController?.viewControllers else { return }
//        // 뷰 스택에서 RedViewController를 찾아서 거기까지 pop 합니다.
//        for viewController in dvc {
//            if let onboardingView = viewController as? OnboardingNC { self.navigationController?.popToViewController(onboardingView, animated: true)
//            }
//        }

        
        
        
    }
    
    // 계속 할래요 버튼
    @IBAction func touchUpContinueBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
