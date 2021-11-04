//
//  SignUpFirstVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/18.
//

import UIKit

class SignUpTermsVC: UIViewController {
    
    // MARK: - Variable
    // 약관동의 배열
    var terms = Array(repeating: false, count: 3)
    
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
    @IBOutlet weak var allAgreeBtn: CheckBtn!
    @IBOutlet var agreeBtn: [CheckBtn]!
    
    // 뒤로가기 버튼
    @IBOutlet weak var backBtn: UIButton!
    
    // 다음 버튼
    @IBOutlet weak var nextBtn: NextBtn!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        kakaoAppleLoginLogic()
        allAgreeBtn.checkDelegate = self
        agreeBtn[0].checkDelegate = self
        agreeBtn[1].checkDelegate = self
        agreeBtn[2].checkDelegate = self
    }
    
    // MARK: - Function
    // style
    private func setStyle() {
        // titleLabel
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.adjusted)
        titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeight: 30.adjusted)
        titleLabel.asColor(targetString: "우피치", color: .main)
        
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
    }
    
    // 카카오, 애플 로그인 로직 나누기
    private func kakaoAppleLoginLogic() {
        if let loginMethod = SignUpUserInfo.shared.loginMethod {
            switch loginMethod {
            case .kakao:
                nextBtn.setTitle("다음 (1/5)", for: .normal)
            case .apple:
                nextBtn.setTitle("다음 (1/6)", for: .normal)
            }
        }
    }
    
    // MARK: - IBActions
    // 다음 버튼
    @IBAction func touchUpNextBtn(_ sender: UIButton) {
        // 전체동의와 이용약관 개인정보 수집 및 이용 버튼이 눌렸을 때 다음 버튼 활성화
        if  nextBtn.backgroundColor == .main {
            
            print("<<<<<<<<<싱글톤에 누른 값들이 잘 저장되었는지 확인>>>>>>>>>>>")
            print("약관동의:", SignUpUserInfo.shared.termsOfUse ?? "값이 없어요")
            print("개인정보 수집:", SignUpUserInfo.shared.privacyInfo ?? "값이 없어요")
            print("푸시알림:", SignUpUserInfo.shared.pushAlert ?? "값이 없어요")
            
            // 버튼 클릭 시, 다음 스토리보드로 이동
            let storyboard = UIStoryboard.init(name: "SignUpCity", bundle: nil)
            
            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpCityVC") as? SignUpCityVC else {return}
            
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        else {
            nextBtn.backgroundColor = .gray03
        }
    }
    
    // 뒤로가기 버튼
    @IBAction func touchUpBackBtn(_ sender: Any) {
        // 데이터가 저장되어있으면 팝업창뜨게하고, 아니면 그냥 뒤로 이동
        if ((SignUpUserInfo.shared.region) != nil) {
            // 팝업 창 띄워줌
            let storyBoard: UIStoryboard = UIStoryboard(name: "JoinAlert", bundle: nil)
            
            if let dvc = storyBoard.instantiateViewController(withIdentifier: "JoinAlertVC") as? JoinAlertVC {
                dvc.modalPresentationStyle = .overFullScreen
                dvc.modalTransitionStyle = .crossDissolve
                
                dvc.alertDelegate = self
                
                // present 형태로 띄우기
                self.present(dvc, animated: true, completion: nil)
            }
        }
        else {
            navigationController?.popViewController(animated: true)
        }
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

// 동의 버튼 로직 delegate
extension SignUpTermsVC : CheckDelegate {
    func pushNext(btn: CheckBtn) {
        switch btn {
            // '전체동의' 버튼이 눌릴 때
        case allAgreeBtn:
            
            // 전체 동의 버튼을 누르면 모든 약관의 상태가 true로 싱글톤에 저장
            SignUpUserInfo.shared.pushAlert = true
            
            // 버튼을 다 동의 버튼으로 만드세요!!
            btn.allAgreeBtnImg()
            for idx in 0..<terms.count {
                agreeBtn[idx].allAgreeBtnImg()
            }
            
        default:
            // 나머지 버튼들
            btn.changeBtnImg()
            if allAgreeBtn.status {
                // 나머지 버튼이 bool값인게 1이상 일 때
                if agreeBtn.filter({!$0.status}).count >= 1 {
                    allAgreeBtn.changeBtnImg()
                }
            }
            // 전체동의 버튼의 상태가 false 일 때
            else {
                // 나머지 버튼이 다 true일 때
                if agreeBtn[0].status && agreeBtn[1].status && agreeBtn[2].status {
                    allAgreeBtn.changeBtnImg()
                }
            }
        }
        
        if agreeBtn[0].status && agreeBtn[1].status {
            nextBtn.backgroundColor = .main
            // 버튼 두개가 눌리면 싱글톤에 저장
        }
        else {
            nextBtn.backgroundColor = .gray03
            // 버튼 두개 중 하나라도 해제시, 초기화
            
        }
    }
}

// 팝업창 Delegate
extension SignUpTermsVC : AlertDelegate {
    func alertDismiss() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        // 뷰 스택에서 OnbordingVC를 찾아서 거기까지 pop 합니다.
        for viewController in viewControllerStack {
            if let onboardingVC = viewController as? OnbordingVC { self.navigationController?.popToViewController(onboardingVC, animated: true)
                SignUpUserInfo.shared.dispose()
            }
        }
    }
}
