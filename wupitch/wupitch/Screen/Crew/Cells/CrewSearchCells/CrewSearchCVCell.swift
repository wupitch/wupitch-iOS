//
//  CrewSearchCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/13.
//

import UIKit

class CrewSearchCVCell: UICollectionViewCell {

    static let identifier = "CrewSearchCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CrewSearchCVCell", bundle: nil)
    }
    
    @IBOutlet weak var crewSearchCV: UICollectionView!
//    var searchDelegate : SearchTextDelegate?
    var tabBar : tabEnum?
    var crewSearch : CrewSearchResult?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveTestNotification(_:)), name: NSNotification.Name("reloadSection"), object: nil)
        
        crewSearchCV.delegate = self
        crewSearchCV.dataSource = self
        self.crewSearchCV.register(CrewCVCell.nib(), forCellWithReuseIdentifier: CrewCVCell.identifier)
        //self.crewSearchCV.register(BungaeCVCell.nib(), forCellWithReuseIdentifier: BungaeCVCell.identifier)
        self.crewSearchCV.register(ReadyCVCell.nib(), forCellWithReuseIdentifier: ReadyCVCell.identifier)
    }
    
    @objc func didRecieveTestNotification(_ notification: Notification) {
        crewSearchCV.reloadSections(IndexSet(integer: 0))
     }
     
    
    func stringDate(doubleDate: Double) -> String {
        let doubleToString = String(doubleDate)
        let stringChange = doubleToString.split(separator: ".")
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        return stringDate
    }
}

extension CrewSearchCVCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tabBar == tabEnum.crew {
            print("갯슈", SignUpUserInfo.shared.crewSearchContent.count)
            return SignUpUserInfo.shared.crewSearchContent.count
        }
        else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tabBar == tabEnum.crew {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewCVCell.identifier, for: indexPath) as? CrewCVCell else{
                return UICollectionViewCell()
            }
            // 크루 이름 + 색상 + 크루 기본 이미지
            switch SignUpUserInfo.shared.crewSearchContent[indexPath.row].sportsID {
            case 1:
                cell.tagNameLabel.text = "축구/풋살"
                cell.tagNameView.backgroundColor = .sub04
                if let crewImage = SignUpUserInfo.shared.crewSearchContent[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgFoot")
                }
            case 2:
                cell.tagNameLabel.text = "배드민턴"
                cell.tagNameView.backgroundColor = .sub03
                if let crewImage = SignUpUserInfo.shared.crewSearchContent[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgBad")
                }
            case 3:
                cell.tagNameLabel.text = "배구"
                cell.tagNameView.backgroundColor = .sub01
                if let crewImage = SignUpUserInfo.shared.crewSearchContent[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgVoll")
                }
            case 4:
                cell.tagNameLabel.text = "농구"
                cell.tagNameView.backgroundColor = .sub02
                if let crewImage = SignUpUserInfo.shared.crewSearchContent[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgBasket")
                }
            case 5:
                cell.tagNameLabel.text = "등산"
                cell.tagNameView.backgroundColor = .sub06
                if let crewImage = SignUpUserInfo.shared.crewSearchContent[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgHike")
                }
            case 6:
                cell.tagNameLabel.text = "런닝"
                cell.tagNameView.backgroundColor = .sub05
                if let crewImage = SignUpUserInfo.shared.crewSearchContent[indexPath.row].crewImage {
                    cell.imageView.sd_setImage(with: URL(string: crewImage))
                } else {
                    cell.imageView.image = UIImage(named: "imgRun")
                }
            default:
                break
            }
            
            // 핀업 버튼이 true일 때
            if SignUpUserInfo.shared.crewSearchContent[indexPath.row].isPinUp == true {
                cell.pinImageView.isHidden = false
            }
            else {
                cell.pinImageView.isHidden = true
            }
            
            // 크루 제목
            cell.titleLabel.text = SignUpUserInfo.shared.crewSearchContent[indexPath.row].clubTitle
            // 크루 날짜
            cell.dayLabels[0].text = SignUpUserInfo.shared.crewSearchContent[indexPath.row].schedules[0].day
            // 시작시간 옵셔널이라서 바인딩
//            if let starTime = SignUpUserInfo.shared.crewSearchContent[indexPath.row].schedules[0].startTime {
//                cell.dayLabels[1].text = stringDate(doubleDate: starTime)
//            } else {
//                cell.dayLabels[1].text = nil
//            }
//            // 끝나는시간 옵셔널이라 바인딩
//            if let endTime = SignUpUserInfo.shared.crewSearchContent[indexPath.row].schedules[0].endTime {
//                cell.dayLabels[3].text = stringDate(doubleDate: endTime)
//            } else {
//                cell.dayLabels[3].text = nil
//            }
//            cell.dayLabels[2].text = "-"
//            // 크루 모이는 날이 많을 경우 '+' 붙여주기
//            if SignUpUserInfo.shared.crewSearchContent[indexPath.row].schedules.count ?? 0 > 1 {
//                cell.dayLabels[4].isHidden = false
//            } else {
//                cell.dayLabels[4].isHidden = true
//            }
            // 장소가 지정되어있지 않을 경우 "장소미정" 뜨게함
            cell.subLabel.text = SignUpUserInfo.shared.crewSearchContent[indexPath.row].areaName ?? "장소미정"
            print("크루 눌렸음")
            
            return cell
        }
        
        else if tabBar == tabEnum.bungae {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadyCVCell.identifier, for: indexPath) as? ReadyCVCell else{
                return UICollectionViewCell()
            }
            print("번개 눌렸을")
            return cell
        }
        
        return UICollectionViewCell()
    }
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if tabBar == tabEnum.crew {
            return CGSize(width: self.frame.width-40, height: 133)
        }
        else {
            return CGSize(width: self.frame.width, height: self.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
    
}


