//
//  MyActivityBungaeMemberVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/17.
//

import UIKit
import XLPagerTabStrip

class MyActivityBungaeMemberVC: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "번개멤버")
    }
    // MARK: - IBOutlet
    @IBOutlet weak var tabTV: UITableView!
    
    // MARK: - Variable
    var bungaeMember: [MyActivityBungaeMemberResult] = []
    lazy var bungaeMemberDataManager = BungaeMemberService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bungaeMemberDataManager.getBungaeMember(delegate: self)
    }
    
    // MARK: - Function
    // 스타일
    private func setStyle() {
        // 테이블 뷰 경계션 없애기
        tabTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
    // TV Delegate & DataSource & Register
    private func setDelegate() {
        tabTV.delegate = self
        tabTV.dataSource = self
        self.tabTV.register(BungaeMemberTVCell.nib(), forCellReuseIdentifier: BungaeMemberTVCell.identifier)
    }
}

// MARK: - TableView Extension
extension MyActivityBungaeMemberVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bungaeMember.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BungaeMemberTVCell.identifier) as? BungaeMemberTVCell else{
            return UITableViewCell()
        }
        // 닉네임
        cell.bungaeMemberLabel.text = bungaeMember[indexPath.row].accountNickname
        // 번개리더일때 아닐때
        if bungaeMember[indexPath.row].isLeader == true {
            cell.bungaeLeaderImageView.isHidden = false
        }
        else {
            cell.bungaeLeaderImageView.isHidden = true
        }
        // 프로필 사진 있을 때 없을 때
        if let profileImage = bungaeMember[indexPath.row].profileImage {
            cell.profileImageView.sd_setImage(with: URL(string: profileImage))
        } else {
            cell.profileImageView.image = UIImage(named: "profileBasic")
        }
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MyActivityBungaeMemberVC {
    func didSuccessBungaeMember(result: [MyActivityBungaeMemberResult]) {
        print("내활동 번개 멤버 데이터가 성공적으로 들어왔습니다.")
        bungaeMember = result
        tabTV.reloadData()
    }
    func failedToRequest(message: String) {
        print("내활동 번개 멤버 데이터가 들어오지 않습니다.")
    }
}

