//
//  AddBoardVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/24.
//

import UIKit

class AddBoardVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var gongjiBtn: CheckBtn!
    @IBOutlet weak var boardTextCountLabel: UILabel!
    @IBOutlet weak var boardTextView: UITextView!
    
    lazy var makeBoardDataManager = MakeBoardService()
    let placeholder = ("게시글을 작성해주세요.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        placeholderSetting()
        titleTextField.delegate = self
    }
    
    private func setStyle() {
        gongjiBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        gongjiBtn.setTitleColor(UIColor.gray02, for: .normal)
        boardTextView.makeRounded(cornerRadius: 8.adjusted)
        boardTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        boardTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        boardTextCountLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        boardTextCountLabel.textColor = .gray03
        
        titleTextField.backgroundColor = .gray05
        titleTextField.borderStyle = .none
        titleTextField.makeRounded(cornerRadius: 8.adjusted)
        titleTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        titleTextField.textColor = .gray03
        titleTextField.addLeftPadding()
    }
    
    func placeholderSetting() {
        boardTextView.delegate = self
        boardTextView.text = "게시글을 작성해주세요."
        boardTextView.textColor = .gray03
    }

    @IBAction func touchUpGongji(_ sender: Any) {
        if gongjiBtn.status == false {
            gongjiBtn.colorCheck()
        }
        else {
            gongjiBtn.grayCheck()
        }
    }
    @IBAction func touchUpNextBtn(_ sender: Any) {
        makeBoardDataManager.postMakeBoard(MakeBoardRequest(contents: boardTextView.text, isNotice: gongjiBtn.status, noticeTitle: titleTextField.text),delegate: self)
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension AddBoardVC: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = .bk
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
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

extension AddBoardVC {
    // 번개 조회 api
    func didSuccessMakeBoard(result: MakeBoardData) {
        print("게시판 글 생성이 성공적으로 들어왔습니다.")
    }
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}
