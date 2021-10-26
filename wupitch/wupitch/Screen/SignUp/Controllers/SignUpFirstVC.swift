//
//  SignUpFirstVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/18.
//

import UIKit

class SignUpFirstVC: UIViewController {
    
    // MARK: - Properties
    // 카카오 & 애플 로그인 시 버튼 라벨을 바꿔줘야 해서 변수 선언
    var nextBtnLabel : UIButton?
    
    // 약관동의 배열
    var terms = Array(repeating: false, count: 5)
    let switchToDigit = [true: 1,false: 0]
    
    // MARK: - IBOutlets
    // 라벨
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // 약관동의 라벨
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    // 보기 버튼
    @IBOutlet weak var firstMoreBtn: UIButton!
    @IBOutlet weak var secMoreBtn: UIButton!
    @IBOutlet weak var thirdMoreBtn: UIButton!
    
    // 동의 버튼
    @IBOutlet weak var allAgreeBtn: UIButton!
    @IBOutlet var agreeBtn: [UIButton]!
    
    // 뒤로가기 버튼
    @IBOutlet weak var backBtn: UIButton!
    
    // 다음 버튼
    @IBOutlet weak var nextBtn: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setBtnNameToDVC()
    }
    
    // MARK: - Function
    // style
    func setStyle() {
        // descriptionLabel
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        descriptionLabel.setTextWithLineHeight(text: descriptionLabel.text, lineHeight: 20.adjusted)
        
        // btnLabel
        firstLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        secondLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        thirdLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        fourthLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        // btns
        allAgreeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        agreeBtn[0].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        agreeBtn[1].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        agreeBtn[2].titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.adjusted)
        
        // moreBtns
        firstMoreBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        secMoreBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        thirdMoreBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        
        // nextBtn
        nextBtn.layer.cornerRadius = 8
        nextBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.adjusted)
        nextBtn.setTitle("다음", for: .normal)
    }
    
    // 카카오 & 애플 로그인 시 버튼 라벨을 바꿔줘야 하기 때문에!
    func setBtnNameToDVC() {
        nextBtn = nextBtnLabel
    }
    
    // 약관동의 나머지 버튼들 클릭시 호출
    func checkAgree(_ idx: Int) {
        terms[idx] = !terms[idx]
        setAgreeImage(idx)
        
        // 약관동의 배열이 전부 True라면
        if terms.allSatisfy({$0}) {
            // 전체 동의 체크 및 이미지 변경
            allAgreeBtn.setImage(UIImage(named: "check"), for: .normal)
        }
        else {
            allAgreeBtn.setImage(UIImage(named: "grayCheck"), for: .normal)
        }
    }
    
    // 나머지 버튼의 체크 이미지 변경
    func setAgreeImage(_ idx: Int) {
        if terms[idx] {
            agreeBtn[idx].setImage(UIImage(named: "check"), for: .normal)
        } else {
            agreeBtn[idx].setImage(UIImage(named: "grayCheck"), for: .normal)
        }
    }
    
    // MARK: - IBActions
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: UIButton) {
        
        // 버튼 클릭 시, 다음 스토리보드로 이동
        let storyboard = UIStoryboard.init(name: "SignUpSecond", bundle: nil)
        
        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpSecondVC") as? SignUpSecondVC else {return}
        
        // 여기에서 카카오인지 애플인지 if else로 나누고 버튼 값이 다르게 들어가야 함
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // 전체동의 버튼
    @IBAction func allAgreeBtnTap(_ sender: Any) {
        if terms.allSatisfy({$0}){
            allAgreeBtn.setImage(UIImage(named: "grayCheck"), for: .normal)
            terms = Array(repeating: false, count: 3)
        }
        else {
            allAgreeBtn.setImage(UIImage(named: "check"), for: .normal)
            terms = Array(repeating: true, count: 3)
        }
        for idx in 0..<terms.count {
            setAgreeImage(idx)
        }
    }
    
    // 이용약관 버튼
    @IBAction func firstBtnTap(_ sender: Any) {
        checkAgree(0)
    }
    
    // 개인정보 수집 및 이용 버튼
    @IBAction func secBtnTap(_ sender: Any) {
        checkAgree(1)
    }
    
    // 푸시 알람 동의 (선택) 버튼
    @IBAction func thirdBtnTap(_ sender: Any) {
        checkAgree(2)
    }
    
    // 이용약관 '보기' 버튼
    @IBAction func touchUpFirstMoreBtn(_ sender: Any) {
        // 버튼 클릭 시, 스토리보드 이동
        let storyboard = UIStoryboard.init(name: "TermsOfUse", bundle: nil)
        
        guard let dvc = storyboard.instantiateViewController(identifier: "TermsOfUseVC") as? TermsOfUseVC else {return}
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 개인정보 수집 및 이용 '보기' 버튼
    @IBAction func touchUpSecondMoreBtn(_ sender: Any) {
        // 버튼 클릭 시, 스토리보드 이동
        let storyboard = UIStoryboard.init(name: "TermsOfUse", bundle: nil)
        
        guard let dvc = storyboard.instantiateViewController(identifier: "AgreeVC") as? AgreeVC else {return}
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    // 푸시 알람 동의 (선택) '보기' 버튼
    @IBAction func touchUpThirdMoreBtn(_ sender: Any) {
    }
}

