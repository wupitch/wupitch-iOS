//
//  MyActivityPhotoPopUpVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/11.
//

import UIKit

class MyActivityPhotoPopUpVC: UIViewController {

    @IBOutlet weak var feedBtn: UIButton!
    @IBOutlet weak var crewBtn: UIButton!
    @IBOutlet weak var popupContentsLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    private func setStyle() {
        // popupView Style
        popupView.layer.cornerRadius = 16.adjusted
        
        // stopBtn style
        crewBtn.layer.cornerRadius = 8.adjusted
        crewBtn.layer.borderWidth = 1.adjusted
        crewBtn.layer.borderColor = UIColor.main.cgColor
        crewBtn.titleLabel?.textColor = .main
        
        // continueBtn Style
        feedBtn.layer.cornerRadius = 8.adjusted
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func touchUpCrewBtn(_ sender: Any) {
    }
    @IBAction func touchUpFeedBtn(_ sender: Any) {
    }
    
}
