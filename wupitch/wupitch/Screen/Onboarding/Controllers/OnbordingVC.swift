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
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var kakaoBtn: UIButton!
    @IBOutlet weak var appleBtn: UIButton!
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    @IBOutlet weak var onboardingCV: UICollectionView!
    @IBOutlet weak var skipBtn: UIButton!
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setDelegate()
        skipBtn.addTarget(self, action: #selector(moveToLast), for: .touchUpInside)
        
    }
    
    // MARK: - Function
    func setStyle() {
       
        kakaoBtn.alpha = 0.0
        appleBtn.alpha = 0.0
        descriptionLabel.alpha = 0.0

        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        descriptionLabel.setTextWithLineHeight(text: "애플로 가입시 별도의 신분증 인증이 필요합니다.", lineHeight: 20)
        
        skipBtn.setTitle("건너뛰기", for: .normal)
        skipBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
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
    
//    func setSkipBtn() {
//        skipBtn.addTarget(self, action: #selector(moveToLast), for: .touchUpInside)
//    }
    
    @objc
    private func moveToLast() {
        onboardingCV.isPagingEnabled = false
        onboardingCV.scrollToItem(at: IndexPath(item: 3, section: 0), at: .centeredHorizontally, animated: true)
        onboardingCV.isPagingEnabled = true
    }
    
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
        
        cell.titleLabel.setTextWithLineHeight(text: onboardingData[indexPath.row].titleLabelName, lineHeight: 38)
        cell.titleLabel.textAlignment = .center
        
        cell.descriptionLabel.setTextWithLineHeight(text: onboardingData[indexPath.row].descriptionLabelName, lineHeight: 20)
        cell.descriptionLabel.textAlignment = .center
        
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

