//
//  JoinAlertVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/26.
//

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
    }
    
    // 계속 할래요 버튼
    @IBAction func touchUpContinueBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
