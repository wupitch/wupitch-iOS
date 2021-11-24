//
//  AddBoardVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

class AddBoardVC: UIViewController {

    @IBOutlet weak var gongjiBtn: UIButton!
    @IBOutlet weak var boardTextCountLabel: UILabel!
    @IBOutlet weak var boardTextView: UITextView!
    
    let placeholder = ("게시글을 작성해주세요.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        placeholderSetting()
    }
    
    private func setStyle() {
        boardTextView.makeRounded(cornerRadius: 8.adjusted)
        boardTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        boardTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        boardTextCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        boardTextCountLabel.textColor = .gray03
    }
    
    func placeholderSetting() {
        boardTextView.delegate = self
        boardTextView.text = "게시글을 작성해주세요."
        boardTextView.textColor = .gray03
    }

    @IBAction func touchUpGongji(_ sender: Any) {
    }
    @IBAction func touchUpNextBtn(_ sender: Any) {
    }
    @IBAction func touchUpBackBtn(_ sender: Any) {
    }
}

extension AddBoardVC: UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray03 {
            textView.text = nil
            textView.textColor = .bk
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요."
            textView.textColor = .gray03
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard textView.text!.count <= 100 else { return false }
        
        boardTextCountLabel.text = "\(textView.text?.count ?? 0)" + "/100"
        boardTextCountLabel.textColor = .gray03
        boardTextCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        
        // 엔터버튼 키보드 내려가기
        if text == "\n" {
            textView.resignFirstResponder()
        }
        
        return true
    }
    
}
