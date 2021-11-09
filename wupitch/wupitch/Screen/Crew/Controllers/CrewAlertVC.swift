//
//  CrewAlertVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/09.
//

import UIKit
import Alamofire

class CrewAlertVC: UIViewController {

    @IBOutlet weak var alertTV: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDeletate()
        setTableViewStyle()
    }
    private func setDeletate() {
        alertTV.delegate = self
        alertTV.dataSource = self
    }
    private func setTableViewStyle() {
        // tableview의 기본 선 제거
        alertTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
}

extension CrewAlertVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.alertTV?.dequeueReusableCell(withIdentifier: CrewAlertTVCell.identifier, for: indexPath) as? CrewAlertTVCell else { return UITableViewCell()
        }
        if indexPath.row == 1 {
            cell.alertTitleLabel.text = "가나다라마바사"
        }
        return cell
    }
}
