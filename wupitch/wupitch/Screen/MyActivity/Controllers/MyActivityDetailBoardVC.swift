//
//  MyActivityDetailBoardVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/16.
//

import UIKit
import XLPagerTabStrip

class MyActivityDetailBoardVC: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "게시판")
    }
    //MARK: - IBOutlet
    @IBOutlet weak var tabTV: UITableView!
    @IBOutlet weak var plusVIew: UIView!
    
    // MARK: - Variable
    var boardData : [LookUpBoardResult] = []
    lazy var lookUpBoardDataManager = LookUpBoardService()
    lazy var likeToggleDataManager = LikeToggleService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
        tapGesture()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lookUpBoardDataManager.getLookUpBoard(delegate: self)
    }
    
    // MARK: - Function
    // 스타일
    private func setStyle() {
        // 테이블 뷰 경계션 없애기
        tabTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        plusVIew.makeRounded(cornerRadius: nil)
    }
    // Delegate & DataSource & Register
    private func setDelegate() {
        tabTV.delegate = self
        tabTV.dataSource = self
        self.tabTV.register(CrewBoardActivityTVCell.nib(), forCellReuseIdentifier: CrewBoardActivityTVCell.identifier)
    }
    // MARK: FloatingView tap gesture
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.screenDidTap(_:)))
        self.plusVIew.addGestureRecognizer(tapGesture)
    }
    
    @objc private func screenDidTap(_ gesture: UITapGestureRecognizer) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "AddBoard", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "AddBoardVC") as? AddBoardVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

// MARK: - TableView Extension
extension MyActivityDetailBoardVC: UITableViewDelegate, UITableViewDataSource {
    // 세로로 몇개 나열할건지?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardData.count
    }
    // 사이즈 자동 조정에 기준이 되는 값
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    // 셀 높이 값
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    // 각 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CrewBoardActivityTVCell.identifier) as? CrewBoardActivityTVCell else {
            return UITableViewCell()
        }
        cell.postId = boardData[indexPath.row].postID
        // 사용자 닉네임
        cell.nicknameLabel.text = boardData[indexPath.row].nickname
        // 게시판 내용
        cell.contentsLabel.text = boardData[indexPath.row].contents
        // 좋아요 수
        cell.likeLabel.text = String(boardData[indexPath.row].likeCount)
        // 작성(수정)날짜
        cell.dateLabel.text = boardData[indexPath.row].date
        // 공지 게시글인지 여부
        if boardData[indexPath.row].isNotice == true {
            cell.gongjiView.isHidden = false
            cell.gongjiContentsLabel.text = boardData[indexPath.row].noticeTitle
        }
        else {
            cell.gongjiView.isHidden = true
        }
        // 작성자 프로필 이미지
        // 있을 때
        if let profileImage = boardData[indexPath.row].accountProfileImage {
            cell.profileImageView.sd_setImage(with: URL(string: profileImage))
            // 없을 때
        } else {
            cell.profileImageView.image = UIImage(named: "profileBasic")
        }
        // 작성자가 크루 리더인지 여부
        if boardData[indexPath.row].isCreatorCrewLeader == true {
            cell.leaderImageView.isHidden = false
        } else {
            cell.leaderImageView.isHidden = true
        }
        // 작성자가 좋아요 눌렀는지 여부
        if boardData[indexPath.row].isAccountLike == true {
            cell.colorBtn()
        } else {
            // 안눌렀으면 회색하트
            cell.grayBtn()
        }
        // 신고를 했는지 여부
        if boardData[indexPath.row].isAccountReport == true {
            // 신고를 이미 했다면 알럿창 띄우기
            presentAlert(title: "신고하기", message: "이미 신고한 게시물입니다.", isCancelActionIncluded: false, preferredStyle: .alert, handler: nil)
//            cell.actionBlock = {
//                if let delegate = cell.boardToLikeOrReport {
//                    delegate.isAccountReportTrue()
//                    print(indexPath.item)
//                }
//            }
        }
        else {
            // 신고를 안했으면 버튼 눌리게
            // cell.BoardToLikeOrReport = self
        }
        // 셀 눌렀을 때 색상 없애주기
        cell.selectionStyle = .none
        return cell
    }
}

extension MyActivityDetailBoardVC: BoardToLikeOrReport {
    func likeBtnTouched(_ index: Int) {
//        UserDefaults.standard.set(index, forKey: "postID")
//        likeToggleDataManager.patchLikeToggle(delegate: self)
    }
    
//    func selectedCVCell(_ index: Int) {
//        let storyboard = UIStoryboard.init(name: "MyActivityAlert", bundle: nil)
//        guard let dvc = storyboard.instantiateViewController(identifier: "MyActivityAlertVC") as? MyActivityAlertVC else {return}
//        dvc.modalPresentationStyle = .overFullScreen
//        dvc.modalTransitionStyle = .crossDissolve
//        present(dvc, animated: true, completion: nil)
//    }
}

extension MyActivityDetailBoardVC {
    func didSuccessLookUpBoard(result: [LookUpBoardResult]) {
        boardData = result
        tabTV.reloadData()
        print("크루 게시판 조회 데이터가 성공적으로 들어왔습니다.")
    }
    func failedToRequest(message: String) {
        print("크루 게시판 조회 데이터가 들어오지 않습니다.")
    }
}


