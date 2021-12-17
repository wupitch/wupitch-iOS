//
//  MyActivityVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import UIKit
// 내활동 VC
class MyActivityVC: BaseVC {
    // MARK: - IBOutlet
    @IBOutlet weak var alertBtn: UIButton!
    @IBOutlet weak var titleLabel: LabelFontSize!
    @IBOutlet weak var MyActivityCV: UICollectionView!
    
    // MARK: - Variable
    // 현재 가입한 크루 조회 API Delegate
    lazy var nowRegisterCrewDataManager = NowRegisterCrewService()
    var nowRegisterData : [NowRegisterCrewResult] = []
    // 현재 가입한 번개 조회 API Delegate
    lazy var nowRegisterBungaeDataManager = NowRegisterBungaeService()
    var nowRegisterBungaeData : [NowRegisterBungaeResult] = []
    
    // MARK: - LifeCycle
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setCVDelegate()
    }
    // ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 현재 가입한 크루 조회 API
        nowRegisterCrewDataManager.getNowRegisterCrew(delegate: self)
        // 현재 가입한 번개 조회 API
        nowRegisterBungaeDataManager.getNowRegisterBungae(delegate: self)
    }
    
    // MARK: - Function
    // 스타일
    private func setStyle() {
        titleLabel.titleLabelFontSize()
    }
    // 더블형 데이터 스트링 값으로 변경하기
    func stringDate(doubleDate: Double) -> String {
        let doubleToString = String(format: "%.2f", doubleDate)
        let stringChange = doubleToString.split(separator: ".")
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        return stringDate
    }
    // 컬렉션뷰 Delegate & DataSource & Register
    private func setCVDelegate() {
        MyActivityCV.delegate = self
        MyActivityCV.dataSource = self
        MyActivityCV.register(ActivityCrewCVCell.nib(), forCellWithReuseIdentifier: ActivityCrewCVCell.identifier)
        MyActivityCV.register(BungaeCVCell.nib(), forCellWithReuseIdentifier: BungaeCVCell.identifier)
        MyActivityCV.register(ReadyCVCell.nib(), forCellWithReuseIdentifier: ReadyCVCell.identifier)
        // 아무것도 없을 때 Cell
        MyActivityCV.register(NoActivityCrewCVCell.nib(), forCellWithReuseIdentifier: NoActivityCrewCVCell.identifier)
        // CV Section Reusable View Cell
        MyActivityCV.register(ActivityCrewCRV.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ActivityCrewCRV")
    }
    
    // MARK: - IBAction
    // 알람 버튼
    @IBAction func touchUpAlertBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CrewAlert", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "CrewAlertVC") as? CrewAlertVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

// MARK: - CollectionView Extension
extension MyActivityVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if nowRegisterData.count <= 0 {
                return 1
            } else {
                return nowRegisterData.count
            }
        } else {
            if nowRegisterBungaeData.count <= 0 {
                return 1
            } else {
                return nowRegisterBungaeData.count
            }
        }
    }
    // 섹션 개수 지정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 활동중인 크루
        if indexPath.section == 0 {
            // 아무것도 없을 때
            if nowRegisterData.count <= 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoActivityCrewCVCell.identifier, for: indexPath) as? NoActivityCrewCVCell else {
                    return UICollectionViewCell()
                }
                cell.lookLabel.text = "+ 크루 둘러보기"
                return cell
            }
            // 활동중인 크루가 있을 때
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCrewCVCell.identifier, for: indexPath) as? ActivityCrewCVCell else {
                    return UICollectionViewCell()
                }
                
                //cell.crewToDetailCrewDelegate = self
                
                // 크루 이름 + 색상 + 크루 기본 이미지
                switch nowRegisterData[indexPath.row].sportsID {
                case 1:
                    cell.tagNameLabel.text = "축구/풋살"
                    cell.tagNameView.backgroundColor = .sub04
                    if let crewImage = nowRegisterData[indexPath.row].crewImage {
                        cell.imageView.sd_setImage(with: URL(string: crewImage))
                    } else {
                        cell.imageView.image = UIImage(named: "imgFoot")
                    }
                case 2:
                    cell.tagNameLabel.text = "배드민턴"
                    cell.tagNameView.backgroundColor = .sub03
                    if let crewImage = nowRegisterData[indexPath.row].crewImage {
                        cell.imageView.sd_setImage(with: URL(string: crewImage))
                    } else {
                        cell.imageView.image = UIImage(named: "imgBad")
                    }
                case 3:
                    cell.tagNameLabel.text = "배구"
                    cell.tagNameView.backgroundColor = .sub01
                    if let crewImage = nowRegisterData[indexPath.row].crewImage {
                        cell.imageView.sd_setImage(with: URL(string: crewImage))
                    } else {
                        cell.imageView.image = UIImage(named: "imgVoll")
                    }
                case 4:
                    cell.tagNameLabel.text = "농구"
                    cell.tagNameView.backgroundColor = .sub02
                    if let crewImage = nowRegisterData[indexPath.row].crewImage {
                        cell.imageView.sd_setImage(with: URL(string: crewImage))
                    } else {
                        cell.imageView.image = UIImage(named: "imgBasket")
                    }
                case 5:
                    cell.tagNameLabel.text = "등산"
                    cell.tagNameView.backgroundColor = .sub06
                    if let crewImage = nowRegisterData[indexPath.row].crewImage {
                        cell.imageView.sd_setImage(with: URL(string: crewImage))
                    } else {
                        cell.imageView.image = UIImage(named: "imgHike")
                    }
                case 6:
                    cell.tagNameLabel.text = "런닝"
                    cell.tagNameView.backgroundColor = .sub05
                    if let crewImage = nowRegisterData[indexPath.row].crewImage {
                        cell.imageView.sd_setImage(with: URL(string: crewImage))
                    } else {
                        cell.imageView.image = UIImage(named: "imgRun")
                    }
                default:
                    break
                }
                // 크루 제목
                cell.titleLabel.text = nowRegisterData[indexPath.row].clubTitle
                // 크루 시간 + 요일
                if let startTime = nowRegisterData[indexPath.row].schedules[0].startTime,
                   let endTime = nowRegisterData[indexPath.row].schedules[0].endTime {
                    if nowRegisterData[indexPath.row].schedules.count > 1 {
                        cell.dayLabel.text = nowRegisterData[indexPath.row].schedules[0].day + " " + stringDate(doubleDate: startTime) + " - " + stringDate(doubleDate: endTime) + " +"
                    } else {
                        cell.dayLabel.text = nowRegisterData[indexPath.row].schedules[0].day + " " + stringDate(doubleDate: startTime) + " - " + stringDate(doubleDate: endTime)
                    }
                } else {
                    print("값이 없어요!")
                }
                // 크루 장소
                cell.subLabel.text = nowRegisterData[indexPath.row].areaName
                return cell
            }
        }
        // 예정된 번개
        else if indexPath.section == 1 {
            // 아무것도 없을 때
            if nowRegisterBungaeData.count <= 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoActivityCrewCVCell.identifier, for: indexPath) as? NoActivityCrewCVCell else{
                    return UICollectionViewCell()
                }
                cell.lookLabel.text = "+ 번개 둘러보기"
                return cell
            }
            // 예정된 번개가 있을 때
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeCVCell.identifier, for: indexPath) as? BungaeCVCell else{
                    return UICollectionViewCell()
                }
                // 자기가 생성한 번개일 때 아닐 때 에이피아이에 주면 추가하기
                //cell.pinImageView.image = UIImage(named: "leader")
                cell.pinImageView.isHidden = true
                // 디데이 숫자가 1일때만 백그라운드 색 진하게
                if nowRegisterBungaeData[indexPath.row].dday <= 1 {
                    cell.tagNameView.backgroundColor = .bk
                    cell.tagNameLabel.textColor = .wht
                }
                else {
                    cell.tagNameView.backgroundColor = .gray03
                    cell.tagNameLabel.textColor = .wht
                }
                // 셀이미지
                if nowRegisterBungaeData[indexPath.row].impromptuImage == nil {
                    cell.imageView.image = UIImage(named: "imgBungae")
                }
                else {
                    cell.imageView.sd_setImage(with: URL(string: nowRegisterBungaeData[indexPath.row].impromptuImage ?? ""))
                }
                // 태그 라벨에 들어가는 D-
                cell.tagNameLabel.text = String("D-") + String(nowRegisterBungaeData[indexPath.row].dday)
                // 제목
                cell.titleLabel.text = nowRegisterBungaeData[indexPath.row].title
                // 요일 + 시간
                cell.dayLabel.text = String(nowRegisterBungaeData[indexPath.row].date) + " " + String(nowRegisterBungaeData[indexPath.row].day) + " " + stringDate(doubleDate: Double(nowRegisterBungaeData[indexPath.row].startTime ?? 0))
                // 장소
                cell.subLabel.text = nowRegisterBungaeData[indexPath.row].location
                // 현재인원 / 모집인원
                cell.bungaeCountLabel.text = String(nowRegisterBungaeData[indexPath.row].nowMemberCount ) + "/" + String(nowRegisterBungaeData[indexPath.row].recruitmentCount)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "ActivityCrewCRV",for: indexPath) as! ActivityCrewCRV
            switch indexPath.section {
            case 0:
                headerView.frame.size.height = 48.0
                headerView.crewLabel.text = "활동중인 크루"
            case 1:
                headerView.frame.size.height = 48.0
                headerView.crewLabel.text = "예정된 번개"
            default:
                headerView.frame.size.height = 0.0
            }
            return headerView
        default:
            assert(false, "응 아니야")
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 48)
        case 1:
            return CGSize(width: collectionView.bounds.width, height: 48)
        default:
            return CGSize(width: collectionView.bounds.width, height: 40)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 활동중인 크루
        if indexPath.section == 0 {
            // cell 누르면 해당 뷰로 이동
            if nowRegisterData.count <= 0 {
                self.tabBarController?.selectedIndex = 0
                // cell 누르면 해당 디테일 페이지로 이동
            } else {
                UserDefaults.standard.set(nowRegisterData[indexPath.row].clubID, forKey: "clubID")
                let storyboard = UIStoryboard.init(name: "MyActivityDetailTab", bundle: nil)
                guard let dvc = storyboard.instantiateViewController(identifier: "MyActivityDetailTabVC") as? MyActivityDetailTabVC else {return}
                dvc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(dvc, animated: true)
            }
            // 예정된 번개
        } else {
            // cell 누르면 해당 뷰로 이동
            if nowRegisterBungaeData.count <= 0 {
                self.tabBarController?.selectedIndex = 1
            }
            // cell 누르면 해당 디테일 페이지로 이동
            else {
                UserDefaults.standard.set(nowRegisterBungaeData[indexPath.row].impromptuID, forKey: "impromptuID")
                let storyboard = UIStoryboard.init(name: "MyActivityBungaeTab", bundle: nil)
                guard let dvc = storyboard.instantiateViewController(identifier: "MyActivityBungaeTabVC") as? MyActivityBungaeTabVC else {return}
                dvc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(dvc, animated: true)
            }
        }
    }
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        // 활동중인 크루 셀 사이즈
        if indexPath.section == 0 {
            return CGSize(width: width-40, height: 170)
            // 에정된 번개 셀 사이즈
        } else {
            return CGSize(width: width-40, height: 144)
        }
    }
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
    }
}

// MARK: - API Extension
extension MyActivityVC {
    // 가입한 크루 조회 API
    func didSuccessNowRegister(result: [NowRegisterCrewResult]) {
        print("현재 가입한 크루 정보를 성공적으로 조회하였습니다.")
        nowRegisterData = result
        MyActivityCV.reloadData()
    }
    // 가입한 번개 조회 API
    func didSuccessNowRegisterBungae(result: [NowRegisterBungaeResult]) {
        print("현재 가입한 번개 정보를 성공적으로 조회하였습니다.")
        nowRegisterBungaeData = result
        MyActivityCV.reloadData()
    }
    func failedToRequest(message: String) {
        print("현재 가입한 크루 및 번개 정보 데이터가 들어오지 않습니다.")
    }
}

// MARK: - Delegate Extension
//extension MyActivityVC: MyCrewToMyCrewDetail {
//    func didPressBoard() {
//        let storyboard = UIStoryboard.init(name: "MyActivityDetailTab", bundle: nil)
//        guard let dvc = storyboard.instantiateViewController(identifier: "MyActivityDetailTabVC") as? MyActivityDetailTabVC else {return}
//        dvc.hidesBottomBarWhenPushed = true
//        dvc.moveToViewController(at: 1, animated: false)
//        self.navigationController?.pushViewController(dvc, animated: true)
//    }
//    func didPressCrewone() {
//        let storyboard = UIStoryboard.init(name: "MyActivityDetailTab", bundle: nil)
//        guard let dvc = storyboard.instantiateViewController(identifier: "MyActivityDetailTabVC") as? MyActivityDetailTabVC else {return}
//        dvc.hidesBottomBarWhenPushed = true
//        dvc.moveToViewController(at: 2, animated: false)
//        self.navigationController?.pushViewController(dvc, animated: true)
//    }
//}
