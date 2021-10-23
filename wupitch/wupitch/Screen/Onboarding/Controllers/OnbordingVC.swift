//
//  testViewController.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/17.
//

// 온보딩에서 해야할 것
// 1. 폰 오토 맞추기 -> 작은 화면에서는 좀 안맞음 (런치스크린도하자-> 런치스크린 아이콘이 작아져야 함)
// 2. 컬렉션 뷰 안에 있는 특정 글자 색 변경하기
// 3. 실제 폰으로 했을 때 온보딩 페이지 컨트롤이 이상함

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
    
    var highlightSentence: String = "동호회"
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setDelegate()
        
    }
    
    // MARK: - Function
    func setStyle() {
        // 처음에는 버튼 & 라벨 안보이게
        kakaoBtn.alpha = 0.0
        appleBtn.alpha = 0.0
        descriptionLabel.alpha = 0.0
        
        // 설명라벨 폰트 및 lineheight 설정
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.adjusted)
        descriptionLabel.setTextWithLineHeight(text: "애플로 가입시 별도의 신분증 인증이 필요합니다.", lineHeight: 20.adjusted)
        
        // skipBtn 폰트 및 lineheight 설정
        skipBtn.setTitle("건너뛰기", for: .normal)
        skipBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.adjusted)
        skipBtn.tintColor = UIColor.gray02
        
        // 페이지 컨트롤 색상 조정
        onboardingPageControl.pageIndicatorTintColor = .gray04
        onboardingPageControl.currentPageIndicatorTintColor = .main
        
        // 컬렉션 뷰 페이징 효과 부드럽게
        onboardingCV.isPagingEnabled = true
        
        // 백그라운드 컬러 설정
        onboardingCV.backgroundColor = .gray05
        view.backgroundColor = .gray05
    }
    
    func setDelegate() {
        // dataSource & Delegate & Register
        onboardingCV.delegate = self
        onboardingCV.dataSource = self
        onboardingCV.register(OnbordingCVCell.nib(), forCellWithReuseIdentifier: OnbordingCVCell.identifier)
    }
    
    // 스크롤 페이지 설정
    private func definePage(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / UIScreen.main.bounds.width))
        print("current page>>>>>\(page)")
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
    @IBAction func touchUpSkipBtn(_ sender: Any) {
        onboardingCV.isPagingEnabled = false
        onboardingCV.scrollToItem(at: IndexPath(item: 3, section: 0), at: .centeredHorizontally, animated: true)
        onboardingCV.isPagingEnabled = true
    }
    
    @IBAction func touchUpKakaoBtn(_ sender: Any) {
        
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    // 로그인 성공 후 회원가입 루트로 이동
                    let storyboard = UIStoryboard.init(name: "SignUpFirst", bundle: nil)
                    
                    guard let dvc = storyboard.instantiateViewController(identifier: "SignUpFirstVC") as? SignUpFirstVC else {return}
                    self.navigationController?.pushViewController(dvc, animated: true)
                    
                    //do something
                    _ = oauthToken
                }
            }
        }
        
        // 카카오 계정으로 로그인
        else { UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                
                // 로그인 성공 후 회원가입 루트로 이동
                let storyboard = UIStoryboard.init(name: "SignUpFirst", bundle: nil)
                
                guard let dvc = storyboard.instantiateViewController(identifier: "SignUpFirstVC") as? SignUpFirstVC else {return}
                self.navigationController?.pushViewController(dvc, animated: true)
                
                _ = oauthToken
            }
        }
        }
        
    }
    
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
        
        cell.titleLabel.setTextWithLineHeight(text: onboardingData[indexPath.row].titleLabelName, lineHeight: 38.adjusted)
        cell.titleLabel.textAlignment = .center
        
        cell.descriptionLabel.setTextWithLineHeight(text: onboardingData[indexPath.row].descriptionLabelName, lineHeight: 20.adjusted)
        cell.descriptionLabel.textAlignment = .center
        
        //        cell.titleLabel.asColor(targetString: "동호회", color: .main)
        //cell.titleLabel.asColor(targetString: onboardingData[0].titleLabelName, color: .main)
        
        
        
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
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        definePage(scrollView)
    }
}

// MARK: Apple Login
extension OnbordingVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    //    func appleLogin(_ sender: ASAuthorizationAppleIDButton) {
    //        let request = ASAuthorizationAppleIDProvider().createRequest()
    //        request.requestedScopes = [.email, .fullName]
    //        let controller = ASAuthorizationController(authorizationRequests: [request])
    //        controller.delegate = self
    //        controller.presentationContextProvider = self
    //        controller.performRequests()
    //    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = credential.user
            let email = credential.email
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
            
            print("애플로그인성공", userIdentifier, email ?? "불러오지못함", fullName)
            
            // 로그인 성공 후 회원가입 루트로 이동
            let storyboard = UIStoryboard.init(name: "SignUpFirst", bundle: nil)
            
            guard let dvc = storyboard.instantiateViewController(identifier: "SignUpFirstVC") as? SignUpFirstVC else {return}
            self.navigationController?.pushViewController(dvc, animated: true)
            
            // 자동로그인을 위해 토근 저장
            // UserDefaults.standard.set(userIdentifier, forKey: "AppleLoginUserIdentifier")
        } else {
            // self.presentAlert(title: "애플로그인 실패")
            print("로그인실패")
        }
    }
}


