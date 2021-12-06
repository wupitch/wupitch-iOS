//
//  MyActivityAlertVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/05.
//

import UIKit

class MyActivityAlertVC: UIViewController {

    @IBOutlet weak var nextBtn: NextBtn!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var alertLabel: LabelFontSize!
    @IBOutlet weak var alertTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeholderSetting()
        nextBtn.colorNextBtnStyle()
        alertTextView.delegate = self
        alertTextView.makeRounded(cornerRadius: 8.adjusted)
        alertTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        alertTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        alertView.makeRounded(cornerRadius: 16.adjusted)
    }
    
    func placeholderSetting() {
        alertTextView.delegate = self
        alertTextView.text = "신고 내용을 입력해주세요."
        alertTextView.textColor = .gray03
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpNextBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MyActivityAlertVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray03 {
            textView.text = nil
            textView.textColor = .bk
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "신고 내용을 입력해주세요."
            textView.textColor = .gray03
        }
    }
}
