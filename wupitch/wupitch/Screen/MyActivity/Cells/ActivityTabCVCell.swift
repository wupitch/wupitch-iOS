//
//  ActivityTabCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/25.
//

import UIKit

class ActivityTabCVCell: UICollectionViewCell {

    static let identifier = "ActivityTabCVCell"
    
    
    @IBOutlet weak var tabTV: UITableView!
    var tabBar : myActivityTab?
    
    static func nib() -> UINib {
        return UINib(nibName: "ActivityTabCVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tabTV.delegate = self
        tabTV.dataSource = self
        self.tabTV.register(BungaeImageCVCell.nib(), forCellReuseIdentifier: BungaeImageCVCell.identifier)
        self.tabTV.register(BungaeTitleCVCell.nib(), forCellReuseIdentifier: BungaeTitleCVCell.identifier)
        self.tabTV.register(DetailCrewIntroduceTVCell.nib(), forCellReuseIdentifier: DetailCrewIntroduceTVCell.identifier)
        self.tabTV.register(DtailCrewContentTVCell.nib(), forCellReuseIdentifier: DtailCrewContentTVCell.identifier)
        self.tabTV.register(DtailCrewContentTVCell.nib(), forCellReuseIdentifier: DtailCrewContentTVCell.identifier)
        self.tabTV.register(BungaeInfoCVCell.nib(), forCellReuseIdentifier: BungaeInfoCVCell.identifier)
        // 테이블 뷰 경계션 없애기
        tabTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
}

extension ActivityTabCVCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tabBar == myActivityTab.introduce {
            return 1
        }
        else if tabBar == myActivityTab.board {
            return 1
        }
        
        else if tabBar == myActivityTab.photo {
            return 1
        }
        
        else {
           return 1
        }
    }
    
    // 섹션
    func numberOfSections(in tableView: UITableView) -> Int {
        if tabBar == myActivityTab.introduce {
            return 6
        }
        else if tabBar == myActivityTab.board {
            return 1
        }
        
        else if tabBar == myActivityTab.photo {
            return 1
        }
        
        else {
           return 1
        }
    }
    // 사이즈 자동 조정에 기준이 되는 값
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 211
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tabBar == myActivityTab.introduce {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeImageCVCell.identifier) as? BungaeImageCVCell else{
                    return UITableViewCell()
                }
                //            // 사진이 있을 때
                //            if detailInfo?.impromptuImage != nil {
                //                cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.impromptuImage ?? ""))
                //            }
                //            // 사진이 없을 때
                //            else {
                //                cell.mainImgView.image = UIImage(named: "imgBungaeThumb")
                //            }
                //
                //            // 핀업이 됐을 때 안됐을 때
                //            if detailInfo?.isPinUp == true {
                //                cell.status = true
                //                cell.pinBtn.setImage(UIImage(named: "selecPin"), for: .normal)
                //            }
                //            else {
                //                cell.status = false
                //                cell.pinBtn.setImage(UIImage(named: "pin"), for: .normal)
                //            }
                return cell
            }
            else if indexPath.section == 1 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeTitleCVCell.identifier) as? BungaeTitleCVCell else{
                    return UITableViewCell()
                }
                
                //            // 디데이 숫자가 1일때만 백그라운드 색 진하게
                //            if  detailInfo?.dday == 1 {
                //                cell.tagView.backgroundColor = .bk
                //                cell.tagLabel.textColor = .wht
                //            }
                //            else {
                //                cell.tagView.backgroundColor = .gray03
                //                cell.tagLabel.textColor = .wht
                //            }
                //
                //            // 나머지
                //            cell.titleLabel.text = detailInfo?.title
                //            cell.tagLabel.text = String("D-") + String(detailInfo?.dday ?? 0)
                //            cell.topDateLabel.text = String(detailInfo?.date ?? "") + " " + String(detailInfo?.day ?? "")
                //            cell.bottomDateLabel.text = stringDate(doubleDate: detailInfo?.startTime ?? -1.0) + " - " + stringDate(doubleDate: detailInfo?.endTime ?? -1.0)
                //            cell.locationLabel.text = detailInfo?.location
                //            cell.moneyLabel.text = "참여비" + " " + String(detailInfo?.dues ?? 0) + "원"
                //            cell.countLabel.text = String(detailInfo?.nowMemberCount ?? 0) + "/" + String(detailInfo?.recruitmentCount ?? 0) + "명 참여"
                
                return cell
            }
            else if indexPath.section == 2 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewIntroduceTVCell.identifier) as? DetailCrewIntroduceTVCell else{
                    return UITableViewCell()
                }
                //            cell.titleLabel.text = "소개"
                //            cell.contentLabel.text = detailInfo?.introduction
                //            cell.peopleLabel.isHidden = true
                //            cell.ageLabel.isHidden = true
                
                return cell
            }
            else if indexPath.section == 3 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DtailCrewContentTVCell.identifier) as? DtailCrewContentTVCell else{
                    return UITableViewCell()
                }
                
                //            cell.titleLabel.text = "준비물"
                //            cell.contentLabel.text = detailInfo?.materials
                
                return cell
            }
            else if indexPath.section == 4 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DtailCrewContentTVCell.identifier) as? DtailCrewContentTVCell else{
                    return UITableViewCell()
                }
                //            cell.titleLabel.text = "문의"
                //            cell.contentLabel.text = detailInfo?.inquiries
                return cell
            }
            else if indexPath.section == 5 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeInfoCVCell.identifier) as? BungaeInfoCVCell else{
                    return UITableViewCell()
                }
                return cell
            }
        }
        else if tabBar == myActivityTab.board {
            
        }
        
        else if tabBar == myActivityTab.photo {
            
        }
        
        else {
           
        }
        return UITableViewCell()
    }
}
