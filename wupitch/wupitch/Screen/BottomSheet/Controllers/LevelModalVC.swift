//
//  LevelModalVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/25.
//

// 다중선택 안되고 두 번 터치 시 꺼짐 꺼질때 버튼 색도 꺼짐
import UIKit

protocol LevelModalDelegate {
    func levelModalDismiss(index: Int)
    func completeBtnToNextBtn()
}

class LevelModalVC: UIViewController {
    
    var levelModalDelegate : LevelModalDelegate?
    var terms = Array(repeating: false, count: 3)
    var btnIndex : Int?
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet var levelBtns: [ModalSportsBtn]!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
    }
    
    func setStyle() {
        // 모달 뷰 둥글게
        modalView.layer.cornerRadius = 16.adjusted
        
        // 컨텐츠 라벨 초기값은 안보이게
        contentsLabel.alpha = 0.0
        contentsLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        contentsLabel.textColor = .gray01
        
        // titleLabel Style
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.adjusted)
        
        // completeBtn Style
        completeBtn.layer.cornerRadius = 8
        completeBtn.backgroundColor = .gray03
        completeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
    }
    
    // cancelBtn
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        if let idx = self.btnIndex {
            levelModalDelegate?.levelModalDismiss(index: idx)
        }
        dismiss(animated: true, completion: nil)
    }
    
    // completeBtn
    @IBAction func touchUpCompleteBtn(_ sender: Any) {
        if completeBtn.backgroundColor == .bk {
            levelModalDelegate?.completeBtnToNextBtn()
            dismiss(animated: true, completion: nil)
        }
        else {
            completeBtn.backgroundColor = .gray03
        }
    }
    
    @IBAction func touchUpHighBtn(_ sender: Any) {
        levelBtns[0].changeModalBtn()
        completeBtn.backgroundColor = .bk
        if levelBtns[0].status {
            levelBtns[1].defaultModalBtnStyle()
            levelBtns[2].defaultModalBtnStyle()
            contentsLabel.alpha = 1
            contentsLabel.text = "상은 이런거야"
        }
    }
    
    @IBAction func touchUpMiddleBtn(_ sender: Any) {
        levelBtns[1].changeModalBtn()
        completeBtn.backgroundColor = .bk
        if levelBtns[1].status {
            levelBtns[0].defaultModalBtnStyle()
            levelBtns[2].defaultModalBtnStyle()
            contentsLabel.alpha = 1
            contentsLabel.text = "중은 이런거야"
        }
    }
    
    @IBAction func touchUpLowBtn(_ sender: Any) {
        levelBtns[2].changeModalBtn()
        completeBtn.backgroundColor = .bk
        if levelBtns[2].status {
            levelBtns[0].defaultModalBtnStyle()
            levelBtns[1].defaultModalBtnStyle()
            contentsLabel.alpha = 1
            contentsLabel.text = "하는 이런거야"
        }
    }
}
