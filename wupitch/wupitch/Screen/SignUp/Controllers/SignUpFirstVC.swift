//
//  SignUpFirstVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/18.
//

import UIKit

class SignUpFirstVC: UIViewController {
    
    @IBOutlet weak var allAgreeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thirdMoreBtn: UIButton!
    @IBOutlet weak var secMoreBtn: UIButton!
    @IBOutlet weak var firstMoreBtn: UIButton!
    @IBOutlet var agreeBtn: [UIButton]!
    //    @IBOutlet weak var agreeLabel: UILabel!
    //    @IBOutlet weak var pushLabel: UILabel!
    //    @IBOutlet weak var privacyLabel: UILabel!
    //    @IBOutlet weak var useLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    // 약관동의 배열
    var terms = Array(repeating: false, count: 5)
    let switchToDigit = [true: 1,false: 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        
    }
    
    func setStyle() {
        // titleLabel
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30)
        titleLabel.asColor(targetString: "우피치", color: .main)
        
        // descriptionLabel
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 20)
        
        // btns
        //allAgreeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        //agreeBtn[0].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        //agreeBtn[1].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        //agreeBtn[2].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        // moreBtns
        //firstMoreBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        //secMoreBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        //thirdMoreBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        
        // nextBtn
        nextBtn.layer.cornerRadius = 8
        //nextBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        
    }
    
    // 약관동의 나머지 버튼들 클릭시 호출
    func checkAgree(_ idx: Int) {
        terms[idx] = !terms[idx]
        setAgreeImage(idx)
        
        // 약관동의 배열이 전부 True라면
        if terms.allSatisfy({$0}) {
            // 전체 동의 체크 및 이미지 변경
            allAgreeBtn.setImage(UIImage(named: "colorCheck.png"), for: .normal)
        }
        else {
            allAgreeBtn.setImage(UIImage(named: "check.png"), for: .normal)
        }
    }
    
    // 나머지 버튼의 체크 이미지 변경
    func setAgreeImage(_ idx: Int) {
        if terms[idx] {
            agreeBtn[idx].setImage(UIImage(named: "colorCheck.png"), for: .normal)
        } else {
            agreeBtn[idx].setImage(UIImage(named: "check.png"), for: .normal)
        }
    }
    
    
    @IBAction func touchUpNextBtn(_ sender: UIButton) {
        print("ㅜㄹ리다")
        
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "SignUpSecond", bundle: nil)
        //        if let dvc = storyBoard.instantiateViewController(withIdentifier: "SignUpSecondNC") as? SignUpSecondNC
        //        {
        //            navigationController?.pushViewController(dvc, animated: true)
        //
        //        }
        //
        let storyboard = UIStoryboard.init(name: "SignUpSecond", bundle: nil)
        
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpSecondNC") as? SignUpSecondNC else {return}
        self.navigationController?.pushViewController(dvc, animated: true)
        
        //        let storyBoard = UIStoryboard.init(name: "SignUpSecond", bundle: nil)
        //        guard let dvc = storyBoard.instantiateViewController(identifier: "SignUpSecondVC") as? SignUpSecondVC  else { return }
        //        let signUpScondNC = UINavigationController(rootViewController: SignUpSecondVC())
        //        self.navigationController?.pushViewController(signUpScondNC, animated: true)
        
    }
    
    @IBAction func allAgreeBtnTap(_ sender: Any) {
        if terms.allSatisfy({$0}){
            allAgreeBtn.setImage(UIImage(named: "check.png"), for: .normal)
            terms = Array(repeating: false, count: 3)
        }
        else {
            allAgreeBtn.setImage(UIImage(named: "colorCheck.png"), for: .normal)
            terms = Array(repeating: true, count: 3)
        }
        for idx in 0..<terms.count {
            setAgreeImage(idx)
        }
    }
    
    @IBAction func firstBtnTap(_ sender: Any) {
        checkAgree(0)
    }
    
    @IBAction func secBtnTap(_ sender: Any) {
        checkAgree(1)
    }
    
    @IBAction func thirdBtnTap(_ sender: Any) {
        checkAgree(2)
    }
    
    
    @IBAction func touchUpTOU(_ sender: Any) {
        
    }
    
    
}

