//
//  CrewDetailTableViewVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/01.
//

import UIKit

class CrewDetailVC: UIViewController {

    @IBOutlet weak var CrewDetailTV: UITableView!
    var sections = [1,2,3]
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
        setCellRegister()
        
        lazy var crewDetailDataManager = CrewDetailService()
        lazy var crewRegisterToggle = CrewRegisterService()
        CrewDetailTV.rowHeight = UITableView.automaticDimension
        
    }
    func setStyle() {
        // 테이블 뷰 경계션 없애기
        CrewDetailTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
    
    func setDelegate() {
        CrewDetailTV.delegate = self
        CrewDetailTV.dataSource = self
    }


    
    // setCellRegister
    func setCellRegister() {
        // cell
        self.CrewDetailTV.register(DetailCrewImgTVCell.nib(), forCellReuseIdentifier: DetailCrewImgTVCell.identifier)
        self.CrewDetailTV.register(DetailCrewTitleTVCell.nib(), forCellReuseIdentifier: DetailCrewTitleTVCell.identifier)
        self.CrewDetailTV.register(DetailCrewIntroduceTVCell.nib(), forCellReuseIdentifier: DetailCrewIntroduceTVCell.identifier)
    }

}

// MARK: - Extension
extension CrewDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewImgTVCell.identifier) as? DetailCrewImgTVCell else{
                return UITableViewCell()
            }
            
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewTitleTVCell.identifier) as? DetailCrewTitleTVCell else{
                return UITableViewCell()
            }
            cell.dayLabel[0].isHidden = true
            cell.dayLabel[1].isHidden = true
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewIntroduceTVCell.identifier) as? DetailCrewIntroduceTVCell else{
                return UITableViewCell()
            }
            cell.tagSelectCV.isHidden = true
            return cell
        }
    }
    
    // 섹션
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
        
    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return 160
//        }
//        else if indexPath.section == 1 {
//            return 150
//        }
//        else if indexPath.section == 2 {
//            return 480
//        }
//        else {
//            return 0
//        }
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 0
//        }
//        if section == 1 {
//            return 0
//        }
//        if section == 2 {
//            return 0
//        }
//        if section == 3 {
//            return 0
//        }
//        if section == 4 {
//            return 0
//        }
//        if section == 5 {
//            return 0
//        }
//        if section == 6 {
//            return 50
//        }
//        else {
//            return 50
//        }
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0 {
//            return UIView(frame: .null)
//        }
//        if section == 1 {
//          return UIView(frame: .null)
//        }
//        if section == 2 {
//          return UIView(frame: .null)
//        }
//        if section == 3 {
//          return UIView(frame: .null)
//        }
//        if section == 4 {
//          return UIView(frame: .null)
//        }
//        if section == 5 {
//          return UIView(frame: .null)
//        }
//        if section == 6 {
//          let headerView = UIView()
//          headerView.backgroundColor = .white
//          headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
//
//          let titleLabel = UILabel()
//          titleLabel.textColor = .black
//          titleLabel.text = "오늘은 요기서 먹어요"
//            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//          titleLabel.frame = CGRect(x: 20, y: 10, width: headerView.frame.width, height: headerView.frame.height)
//          headerView.addSubview(titleLabel)
//
//          return headerView
//        }
//        else {
//            homeHashTagVC = HomeHashTagVC(nibName: "HomeHashTagVC", bundle: nil)
//
//          let headerView = UIView()
//          headerView.backgroundColor = .red
//          headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
//
//            headerView.addSubview(homeHashTagVC!.view)
//
//            self.addChild(homeHashTagVC!)
//
//            // autolayout
//            homeHashTagVC!.view.translatesAutoresizingMaskIntoConstraints = false
//
//            homeHashTagVC!.view.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
//            homeHashTagVC!.view.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
//            homeHashTagVC!.view.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
//            homeHashTagVC!.view.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
//
//            // 하위 컨트롤러가 컨트롤러 권한을 상위컨트롤러로 위임
//            homeHashTagVC!.didMove(toParent: self)
//
//
//          return headerView
//        }
//    }
}

extension CrewDetailVC {
    func didSuccessCrewDetail(result: CrewDetailResult) {
        print("크루 디테일 조회 데이터가 성공적으로 들어왔습니다.")
//        self.detailInfo = result
//        detailCV.reloadData()
    }

    func didSuccessCrewRegister(result: CrewRegisterData) {
        print("크루 등록 토글이 성공적으로 들어옵니다.")
        print(result.message)
    }

    func didSuccessPinUpToggle(result: PinUpToggleData) {
        print("핀업 토글이 성공적으로 들어옵니다.")
        print(result.message)
//        detailCV.reloadData()
    }

    func failedToRequest(message: String) {
        print("크루 디테일 조회 데이터가 들어오지 않았습니다.")

    }
}

extension CrewDetailVC: IntroduceDelegate {
    func dismissIntroducePopup() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ProfileNickname", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(withIdentifier: "ProfileNicknameVC") as? ProfileNicknameVC {
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}
