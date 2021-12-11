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
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
        self.tabTV.register(CrewBoardActivityTVCell.nib(), forCellReuseIdentifier: CrewBoardActivityTVCell.identifier)
        self.tabTV.register(BungaeMemberTVCell.nib(), forCellReuseIdentifier: BungaeMemberTVCell.identifier)
        // 테이블 뷰 경계션 없애기
        tabTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
}

extension ActivityTabCVCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tabBar {
        case .introduce:
            return 1
        case .board:
            return 5
        case .photo:
            return 1
        case .crewone:
            return 10
        default:
            return 0
        }
    }
    
    // 섹션
    func numberOfSections(in tableView: UITableView) -> Int {
        if tabBar == myActivityTab.introduce {
            return 6
        }
        return 1
    }
    // 사이즈 자동 조정에 기준이 되는 값
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 600
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if tabBar == myActivityTab.introduce {
//            if indexPath.section == 0 {
//                return 211
//            }
//            else {
//                return UITableView.automaticDimension
//            }
//        }
//        else if tabBar == myActivityTab.board {
//            return UITableView.automaticDimension
//        }
//
//        else if tabBar == myActivityTab.photo {
//            return UITableView.automaticDimension
//        }
//
//        else if tabBar == myActivityTab.crewone{
           return 60
//        }
//        return CGFloat()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("log<<<<>>>>\(tabBar)")
        if tabBar == myActivityTab.introduce {
        }
        else if tabBar == myActivityTab.board {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CrewBoardActivityTVCell.identifier) as? CrewBoardActivityTVCell else{
                return UITableViewCell()
            }
//            cell.gongjiView.isHidden = true
//            cell.gongjiLabel.isHidden = true
//            cell.gongjiContentsLabel.isHidden = true
            return cell
        }
        else if tabBar == myActivityTab.photo {
            return UITableViewCell()
        }
        else if tabBar == myActivityTab.crewone {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeMemberTVCell.identifier) as? BungaeMemberTVCell else{
                return UITableViewCell()
            }
            return cell
        }
        return UITableViewCell()
    }
}
