//
//  testViewController.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/17.
//

// 온보딩에서 해야할 것
// 1. 페이지연결
// 2. 폰 오토 맞추기 -> 작은 화면에서는 이상하게 나와 (런치스크린도하자-> 런치스크린 아이콘이 작아져야 함)
// 3. 건너뛰기 로직짜기
// 4. 건너뛰기 할 때 인디케이터 같이 움직이게 하기

import UIKit

class OnbordingVC: UIViewController {
    
    // MARK: - IBOulets
    @IBOutlet weak var kakaoLoginView: UIView!
    @IBOutlet weak var appleLoginView: UIView!
    @IBOutlet weak var needIDLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var skipToCreateView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    @IBOutlet weak var onboardingCV: UICollectionView!
    @IBOutlet weak var skipBtn: UIButton!
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setDelegate()
        setSkipBtn()
        
    }
    
    // MARK: - Function
    func setStyle() {
        // 소셜로그인 뷰 동그랗게
        kakaoLoginView.layer.cornerRadius = kakaoLoginView.frame.width / 2
        appleLoginView.layer.cornerRadius = appleLoginView.frame.width / 2
        
        // 건너뛰기 버튼 눌렀을 때 나오는 뷰
        skipToCreateView.alpha = 0.0
        
        // 라벨 텍스트 & 폰트 설정
        startLabel.text = "간편하게 시작하기"
        startLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        
        needIDLabel.text = "애플로 가입시 별도의 신분증 인증이 필요합니다."
        needIDLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        
        titleLabel.text = "내가 원하는 팀 스포츠\n동호회를 한 눈에!"
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .bk
        
        descriptionLabel.text = "지역구를 기반으로 원하는 동호회를 찾아보세요."
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textColor = .gray02
        
        skipBtn.setTitle("건너뛰기", for: .normal)
        skipBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        skipBtn.tintColor = UIColor.gray01
        
        
        // 페이지 컨트롤 색상 조정
        onboardingPageControl.pageIndicatorTintColor = .gray04
        onboardingPageControl.currentPageIndicatorTintColor = .gray03
        
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
    
    func setSkipBtn() {
        skipBtn.addTarget(self, action: #selector(moveToLast), for: .touchUpInside)
    }
    
    @objc
    private func moveToLast() {
        onboardingCV.scrollToItem(at: IndexPath(row: 3, section: 0), at: .left, animated: true)
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
        cell.setCell(imageName: onboardingImgData[indexPath.row].onboardingImageName)
        onboardingPageControl.numberOfPages = onboardingLabelData.count
        
        //titleLabel.text = onboardingLabelData[indexPath.row].titleLabelName
        //descriptionLabel.text = onboardingLabelData[indexPath.row].descriptionLabelName
        
        return cell
    }
    
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        let height =  self.onboardingCV.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - pageControl
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let page = Int(targetContentOffset.pointee.x / self.onboardingCV.frame.width)
        self.onboardingPageControl.currentPage = page
        
        if page == 0 {
            titleLabel.text = "내가 원하는 팀 스포츠\n동호회를 한 눈에!"
            descriptionLabel.text = "지역구를 기반으로 원하는 동호회를 찾아보세요."
            skipBtn.alpha = 1
            skipToCreateView.alpha = 0.0
        }
        else if page == 1 {
            titleLabel.text = "번개와 리그를 통해\n함께 운동하세요"
            descriptionLabel.text = "번개모임과 팀 리그를 조직하고 참여하세요."
            skipBtn.alpha = 1
            skipToCreateView.alpha = 0.0
        }
        else if page == 2 {
            titleLabel.text = "내 활동에서 확인하는\n나의 동호회 이야기"
            descriptionLabel.text = "공지사항부터 사진까지 동호회 소식을 확인하세요."
            skipBtn.alpha = 1
            skipToCreateView.alpha = 0.0
        }
        else {
            titleLabel.text = "피드를 통해 나누는\n스포츠 정신!"
            descriptionLabel.text = "서로의 스포츠 활동 사진을 공유하세요."
            skipBtn.alpha = 0.0
            skipToCreateView.alpha = 1
        }
    }
}

