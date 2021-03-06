//
//  CrewSearchCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/13.
//

import UIKit

protocol CellDelegate: NSObjectProtocol{
    func pressCell(sender: Any)
    func pressBungaeCell(sender: Any)
}

class CrewSearchCVCell: UICollectionViewCell {
    
    static let identifier = "CrewSearchCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CrewSearchCVCell", bundle: nil)
    }
    
    @IBOutlet weak var crewSearchCV: UICollectionView!
    var tabBar : tabEnum?
    var crewSearch : CrewSearchResult?
    var cellDelegate : CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveTestNotification(_:)), name: NSNotification.Name("reloadSection"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveNotification(_:)), name: NSNotification.Name("reloadBungaeSection"), object: nil)
        
        crewSearchCV.delegate = self
        crewSearchCV.dataSource = self
        self.crewSearchCV.register(CrewCVCell.nib(), forCellWithReuseIdentifier: CrewCVCell.identifier)
        self.crewSearchCV.register(BungaeCVCell.nib(), forCellWithReuseIdentifier: BungaeCVCell.identifier)
        self.crewSearchCV.register(ReadyCVCell.nib(), forCellWithReuseIdentifier: ReadyCVCell.identifier)
    }
    
    @objc func didRecieveTestNotification(_ notification: Notification) {
        crewSearchCV.reloadSections(IndexSet(integer: 0))
    }
    
    @objc func didRecieveNotification(_ notification: Notification) {
        crewSearchCV.reloadSections(IndexSet(integer: 0))
    }
    
    func stringDate(doubleDate: Double) -> String {
        let doubleToString = String(format: "%.2f", doubleDate)
        let stringChange = doubleToString.split(separator: ".")
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        return stringDate
    }
}

extension CrewSearchCVCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tabBar == tabEnum.crew {
            return SignUpUserInfo.shared.crewSearchContent.count
        }
        else {
            return SignUpUserInfo.shared.bungaeSearchContent.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tabBar == tabEnum.crew {
            if SignUpUserInfo.shared.crewSearchContent.count >= 1 {
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
                if let starTime = SignUpUserInfo.shared.crewSearchContent[indexPath.row].schedules[0].startTime {
                    cell.dayLabels[1].text = stringDate(doubleDate: starTime)
                } else {
                    cell.dayLabels[1].text = nil
                }
                // 끝나는시간 옵셔널이라 바인딩
                if let endTime = SignUpUserInfo.shared.crewSearchContent[indexPath.row].schedules[0].endTime {
                    cell.dayLabels[3].text = stringDate(doubleDate: endTime)
                } else {
                    cell.dayLabels[3].text = nil
                }
                cell.dayLabels[2].text = "-"
                // 크루 모이는 날이 많을 경우 '+' 붙여주기
                if SignUpUserInfo.shared.crewSearchContent[indexPath.row].schedules.count ?? 0 > 1 {
                    cell.dayLabels[4].isHidden = false
                } else {
                    cell.dayLabels[4].isHidden = true
                }
                // 장소가 지정되어있지 않을 경우 "장소미정" 뜨게함
                cell.subLabel.text = SignUpUserInfo.shared.crewSearchContent[indexPath.row].areaName ?? "장소미정"
                print("크루 눌렸음")
                
                return cell
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadyCVCell.identifier, for: indexPath) as? ReadyCVCell else{
                    return UICollectionViewCell()
                }
                cell.readyLabel.text = "크루에 대한 검색결과가 없어요."
                return cell
            }
        }
        
        else if tabBar == tabEnum.bungae {
            if SignUpUserInfo.shared.bungaeSearchContent.count >= 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BungaeCVCell.identifier, for: indexPath) as? BungaeCVCell else{
                    return UICollectionViewCell()
                }
                print("번개 눌렸을")
                // 디데이 숫자가 1일때만 백그라운드 색 진하게
                if  SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].dday == 1 {
                    cell.tagNameView.backgroundColor = .bk
                    cell.tagNameLabel.textColor = .wht
                }
                else {
                    cell.tagNameView.backgroundColor = .gray03
                    cell.tagNameLabel.textColor = .wht
                }
                
                // 셀이미지
                if SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].impromptuImage == nil {
                    cell.imageView.image = UIImage(named: "imgBungae")
                }
                else {
                    cell.imageView.sd_setImage(with: URL(string: SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].impromptuImage ?? ""))
                }
                
                cell.tagNameLabel.text = String("D-") + String(SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].dday)
                
                cell.titleLabel.text = SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].title
                cell.dayLabel.text = String(SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].date) + " " + String(SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].day) + " " + stringDate(doubleDate: Double(SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].startTime))
                cell.subLabel.text = SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].location
                cell.bungaeCountLabel.text = String(SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].nowMemberCount ) + "/" + String(SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].recruitmentCount)
                
                // 핀업버튼이 true일 때
                if SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].isPinUp == true {
                    cell.pinImageView.isHidden = false
                }
                else {
                    cell.pinImageView.isHidden = true
                }
                return cell
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadyCVCell.identifier, for: indexPath) as? ReadyCVCell else{
                    return UICollectionViewCell()
                }
                cell.readyLabel.text = "번개에 대한 검색결과가 없어요."
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if tabBar == tabEnum.crew {
            cellDelegate?.pressCell(sender: UserDefaults.standard.set(SignUpUserInfo.shared.crewSearchContent[indexPath.row].clubID, forKey: "clubID"))
        }
        else {
            cellDelegate?.pressBungaeCell(sender: UserDefaults.standard.set(SignUpUserInfo.shared.bungaeSearchContent[indexPath.row].impromptuID, forKey: "impromptuID"))
        }
    }
    // MARK: - collectionView size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if tabBar == tabEnum.crew {
            return CGSize(width: self.frame.width-40, height: 133)
        }
        else {
            return CGSize(width: self.frame.width-40, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
    
}


