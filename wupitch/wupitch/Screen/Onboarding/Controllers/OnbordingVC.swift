//
//  testViewController.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/17.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

class OnbordingVC: UIViewController {
    // MARK: - IBOulets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var kakaoBtn: UIButton!
    @IBOutlet weak var appleBtn: UIButton!
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    @IBOutlet weak var onboardingCV: UICollectionView!
    @IBOutlet weak var skipBtn: UIButton!
    
    // Kakao, Apple SignIn Api 연동
    lazy var kakaoDataManager: KakaoLoginService = KakaoLoginService()
    lazy var appleDataManager: AppleLoginService = AppleLoginService()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
    }
    
    // MARK: - Function
    // style
    func setStyle() {
        // 처음에는 버튼 & 라벨 안보이게
        kakaoBtn.alpha = 0.0
        appleBtn.alpha = 0.0
        descriptionLabel.alpha = 0.0
        
        // 설명라벨 폰트 및 lineheight 설정
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        descriptionLabel.textColor = .gray02
        descriptionLabel.setTextWithLineHeight(text: "애플로 가입시 별도의 신분증 인증이 필요합니다.", lineHeight: 20.adjusted)
        descriptionLabel.textAlignment = .center
        
        // skipBtn 폰트 및 lineheight 설정
        skipBtn.setTitle("건너뛰기", for: .normal)
        skipBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        skipBtn.tintColor = UIColor.gray02
        
        // kakaoBtn 폰트 및 cornerRadius
        kakaoBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        kakaoBtn.backgroundColor = UIColor(red: 254/255, green: 229/255, blue: 0/255, alpha: 1)
        kakaoBtn.makeRounded(cornerRadius: 8.adjusted)
        appleBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14.adjusted)
        appleBtn.backgroundColor = .black
        appleBtn.makeRounded(cornerRadius: 8.adjusted)
        
        // 페이지 컨트롤 색상 조정
        onboardingPageControl.pageIndicatorTintColor = .gray04
        onboardingPageControl.currentPageIndicatorTintColor = .bk
        
        // 컬렉션 뷰 페이징 효과 부드럽게
        onboardingCV.isPagingEnabled = true
        
        // 백그라운드 컬러 설정
        onboardingCV.backgroundColor = .gray05
        view.backgroundColor = .gray05
    }
    
    // dataSource & Delegate & Register
    func setDelegate() {
        onboardingCV.delegate = self
        onboardingCV.dataSource = self
        onboardingCV.register(OnbordingCVCell.nib(), forCellWithReuseIdentifier: OnbordingCVCell.identifier)
    }
    
    // 스크롤 페이지 설정
    private func definePage(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / UIScreen.main.bounds.width))
        //        print("current page>>>>>\(page)")
        self.onboardingPageControl.currentPage = page
        
        if page == 3 {
            skipBtn.alpha = 0.0
            kakaoBtn.alpha = 1
            appleBtn.alpha = 1
            descriptionLabel.alpha = 1
        }
        else {
            skipBtn.alpha = 1
            kakaoBtn.alpha = 0.0
            appleBtn.alpha = 0.0
            descriptionLabel.alpha = 0.0
        }
    }
    
    // MARK: - IBActions
    // 건너뛰기 버튼
    @IBAction func touchUpSkipBtn(_ sender: Any) {
        onboardingCV.isPagingEnabled = false
        onboardingCV.scrollToItem(at: IndexPath(item: 3, section: 0), at: .centeredHorizontally, animated: true)
        onboardingCV.isPagingEnabled = true
    }
    
    // 카카오 로그인 버튼
    @IBAction func touchUpKakaoBtn(_ sender: Any) {
        
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    // 로그인 성공 후 이동할 회원가입 루트
                    let storyboard = UIStoryboard.init(name: "SignUpTerms", bundle: nil)
                    guard let dvc = storyboard.instantiateViewController(identifier: "SignUpTermsVC") as? SignUpTermsVC else {return}
                    
                    // 카카오 로그인으로 진입 시, 버튼 라벨 (1/5)으로 변경
                    SignUpUserInfo.shared.loginMethod = .kakao
                    
                    //do something
                    _ = oauthToken
                    // 카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                    UserApi.shared.me() { [self](user, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            let userEmail = user?.kakaoAccount?.email ?? "이메일을 불러오지 못함"
                            let userGender = user?.kakaoAccount?.gender?.rawValue ?? "성별을 불러오지 못함"
                            let userId = user?.id ?? 0
                            let userNickname = user?.kakaoAccount?.profile?.nickname ?? "닉네임을 불러오지 못함"
                    
                            _ = user
                            // 유저의 정보를 서버에 보냄
                            kakaoDataManager.postKakaoLogin(KakaoLoginRequest(email: userEmail, genderType: userGender.uppercased(), id: userId, nickname: userNickname), delegate: self)
                            
                            // 이동
                            self.navigationController?.pushViewController(dvc, animated: true)
                        }
                    }
                }
            }
        }
        
        // 카카오 계정으로 로그인 (카카오가 깔려있지 않은 경우)
        else { UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                // 로그인 성공 후 이동할 회원가입 루트
                let storyboard = UIStoryboard.init(name: "SignUpTerms", bundle: nil)
                guard let dvc = storyboard.instantiateViewController(identifier: "SignUpTermsVC") as? SignUpTermsVC else {return}
                
                // 카카오 로그인으로 진입 시, 버튼 라벨 (1/5)으로 변경
                SignUpUserInfo.shared.loginMethod = .kakao
                
                _ = oauthToken
                // 카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                UserApi.shared.me() { [self](user, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        let userEmail = user?.kakaoAccount?.email ?? "이메일을 불러오지 못함"
                        let userGender = user?.kakaoAccount?.gender?.rawValue ?? "성별을 불러오지 못함"
                        let userId = user?.id ?? 0
                        let userNickname = user?.kakaoAccount?.profile?.nickname ?? "닉네임을 불러오지 못함"
                
                        _ = user
                        
                        // 유저의 정보를 서버에 보냄
                        kakaoDataManager.postKakaoLogin(KakaoLoginRequest(email: userEmail, genderType: userGender.uppercased(), id: userId, nickname: userNickname), delegate: self)
                        
                        // 이동
                        self.navigationController?.pushViewController(dvc, animated: true)
                    }
                }
            }
        }
    }}
    
    // 애플 로그인 버튼
    @IBAction func touchUpAppleBtn(_ sender: ASAuthorizationAppleIDButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

// MARK: - DataSource & Delegate
extension OnbordingVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnbordingCVCell.identifier, for: indexPath) as? OnbordingCVCell else{
            return UICollectionViewCell()
        }
        
        cell.setCell(title: onboardingData[indexPath.row].titleLabelName, description: onboardingData[indexPath.row].descriptionLabelName, imageName: onboardingData[indexPath.row].onboardingImageName)
        
        onboardingPageControl.numberOfPages = onboardingData.count
        
        return cell
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        let height =  collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - pageControl
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        definePage(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        definePage(scrollView)
    }
}

// MARK: - Apple Login
extension OnbordingVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = credential.user
            let identityToken = credential.identityToken
            let email = credential.email ?? ""
            let familyName = credential.fullName?.familyName ?? ""
            let givenName = credential.fullName?.givenName ?? ""
            let fullName = familyName + givenName
            
            //            self.presentAlert(
            //                title: "애플로그인 성공",
            //                message: """
            //                    userIdentifier : \(userIdentifier)
            //                    email : \(email ?? "불러오지 못함")
            //                    fullName : \((fullName.count > 0) ? fullName : "불러오지 못함")
            //                """
            //            )
            
            // 서버에게 사용자 정보 전달
            appleDataManager.postKakaoLogin(AppleLoginRequest(email: email, nickname: fullName), delegate: self)
            
            // 로그인 성공 후 회원가입 루트로 이동
            let storyboard = UIStoryboard.init(name: "SignUpTerms", bundle: nil)
            
            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpTermsVC") as? SignUpTermsVC else {return}
            
            // 애플 로그인으로 진입 시, 버튼 라벨 (1/6)으로 변경
            SignUpUserInfo.shared.loginMethod = .apple
            
            self.navigationController?.pushViewController(dvc, animated: true)
            
            // 자동로그인을 위해 토근 저장
            // UserDefaults.standard.set(userIdentifier, forKey: "AppleLoginUserIdentifier")
        } else {
            // self.presentAlert(title: "애플로그인 실패")
            print("로그인실패")
        }
    }
}

// 카카오, 애플 api 연결
extension OnbordingVC {
    func didSuccessKakaoLogin(result: KakaoLoginResult) {
        print("데이터가 성공적으로 들어왔습니다.")
        print("유저아이디: ", result.accountID, "jwt: ", result.jwt, "oauthID: ", result.oauthID)
    }
    
    func didSuccessAppleLogin(result: AppleLoginResult) {
        print("데이터가 성공적으로 들어왔습니다.")
        print("유저아이디: ", result.accountID, "jwt: ", result.jwt, "oauthID: ", result.oauthID)
    }
    
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    }
}

