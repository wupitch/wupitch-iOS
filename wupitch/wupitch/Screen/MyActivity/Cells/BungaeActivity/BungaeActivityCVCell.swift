//
//  BungaeActivityCVCell.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/09.
//

import UIKit

protocol YourCellDelegate: NSObjectProtocol{
    func didPressCell(sender: Any)
}

class BungaeActivityCVCell: UICollectionViewCell {

    @IBOutlet weak var tabTV: UITableView!
    var tabBar : myActivityBungaeTab?
    var delegate:YourCellDelegate?
    
    static let identifier = "BungaeActivityCVCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BungaeActivityCVCell", bundle: nil)
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
        self.tabTV.register(BungaeMemberTVCell.nib(), forCellReuseIdentifier: BungaeMemberTVCell.identifier)
        // 테이블 뷰 경계션 없애기
        tabTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
}

extension BungaeActivityCVCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 번개 디테일 탭
        if tabBar == myActivityBungaeTab
            .bungaeIntroduce {
            return 1
        }
        // 번개 멤버 탭
        else if tabBar == myActivityBungaeTab.bungaeCrewone {
            return 5
        }
        return Int()
    }
    // 섹션
    func numberOfSections(in tableView: UITableView) -> Int {
        if tabBar == myActivityBungaeTab
            .bungaeIntroduce {
            return 6
        }
        else if tabBar == myActivityBungaeTab.bungaeCrewone {
            return 1
        }
        return Int()
    }
    // 사이즈 자동 조정에 기준이 되는 값
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tabBar == myActivityBungaeTab.bungaeIntroduce{
            if indexPath.section == 0 {
                return 211
            }
            else {
                return UITableView.automaticDimension
            }
        }
        else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tabBar == myActivityBungaeTab.bungaeIntroduce {
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
        else if tabBar == myActivityBungaeTab.bungaeCrewone {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeMemberTVCell.identifier) as? BungaeMemberTVCell else{
                return UITableViewCell()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tabBar == myActivityBungaeTab.bungaeIntroduce {
            
        }
        else {
            // 딜리게이트로 프로필 뷰
            delegate?.didPressCell(sender: indexPath)
        }
    }
}
