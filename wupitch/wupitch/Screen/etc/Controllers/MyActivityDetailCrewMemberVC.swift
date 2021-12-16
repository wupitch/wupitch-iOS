//
//  MyActivityDetailCrewMember.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/16.
//

import UIKit
import XLPagerTabStrip
import SDWebImage

class MyActivityDetailCrewMemberVC: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "크루원")
    }
    
    @IBOutlet weak var tabTV: UITableView!
    var myActivityCrewMemberDataManager = MyActivityCrewMemberService()
    var crewMember : [MyActivityCrewMemberResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myActivityCrewMemberDataManager.getMyActivityCrewMember(delegate: self)
    }
    // MARK: - Function
    // 스타일
    private func setStyle() {
        // 테이블 뷰 경계션 없애기
        tabTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
    // Delegate & DataSource & Register
    private func setDelegate() {
        tabTV.delegate = self
        tabTV.dataSource = self
        self.tabTV.register(BungaeMemberTVCell.nib(), forCellReuseIdentifier: BungaeMemberTVCell.identifier)
    }
}

// MARK: - TableView Extension
extension MyActivityDetailCrewMemberVC: UITableViewDelegate, UITableViewDataSource {
    // 세로로 몇개 나열할건지?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crewMember.count
    }
    // 셀 높이 값
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    // 각 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeMemberTVCell.identifier) as? BungaeMemberTVCell else {
            return UITableViewCell()
        }
        cell.bungaeMemberLabel.text = crewMember[indexPath.row].accountNickname
        // 이미지 있을 때 없을 때
        if let profileImage = crewMember[indexPath.row].profileImage {
            cell.profileImageView.sd_setImage(with: URL(string: profileImage))
        } else {
            cell.profileImageView.image = UIImage(named: "profileBasic")
        }
        // 멤버 수락 상태
        // 수락상태가 아닐 때
        if crewMember[indexPath.row].isValid == false {
            cell.waitView.isHidden = false
        } else {
            // 수락상태일 때
            cell.waitView.isHidden = true
        }
        // 리더일 때
        if crewMember[indexPath.row].isLeader == true {
            cell.bungaeLeaderImageView.isHidden = false
        } else {
            cell.bungaeLeaderImageView.isHidden = true
        }
        // 셀 눌렀을 때 색상 없애주기
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 멤버 상세 페이지 나오면 여기에 유저디폴트 써주기
        let storyBoard: UIStoryboard = UIStoryboard(name: "BungaeMemberDetail", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "BungaeMemberDetailVC") as? BungaeMemberDetailVC {
            dvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

extension MyActivityDetailCrewMemberVC {
    func didSuccessMyActivityCrewMember(result: [MyActivityCrewMemberResult]) {
        print("내활동 크루 멤버 데이터가 성공적으로 들어왔습니다.")
        crewMember = result
        tabTV.reloadData()
    }
    func failedToRequest(message: String) {
        print("내활동 크루 멤버 데이터가 들어오지 않습니다.")
    }
}
