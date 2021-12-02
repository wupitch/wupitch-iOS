//
//  CrewAlertVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/09.
//

import UIKit
import Alamofire

class CrewAlertVC: UIViewController {
    
    var fcmData : [FCMResult]?
    lazy var fcmDataManager = FCMService()
    @IBOutlet weak var alertTV: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDeletate()
        setTableViewStyle()
        fcmDataManager.postFCM(delegate: self)
    }
    private func setDeletate() {
        alertTV.delegate = self
        alertTV.dataSource = self
        self.alertTV.register(CrewAlertNoTVCell.nib(), forCellReuseIdentifier: CrewAlertNoTVCell.identifier)
    }
    private func setTableViewStyle() {
        // tableview의 기본 선 제거
        alertTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
    
    // MARK: - Date & Time
    func nowDateFormatter(dateLabel: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: Date())
        print(current_date_string)
        let dateLabel = current_date_string
        return dateLabel
    }
    
    @IBAction func touchUpBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CrewAlertVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return fcmData?.count ?? -99
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = self.alertTV?.dequeueReusableCell(withIdentifier: CrewAlertTVCell.identifier, for: indexPath) as? CrewAlertTVCell else { return UITableViewCell()
        }
        cell.alertTitleLabel.text = fcmData?[indexPath.row].title
        cell.alertTimeLabel.text = nowDateFormatter(dateLabel: cell.alertTimeLabel.text ?? "")
        
        return cell
    }
    
}


// FCM api 연결
extension CrewAlertVC {
    func didSuccessFCM(result: [FCMResult]) {
        print("FCM 데이터가 성공적으로 들어왔습니다.")
        fcmData = result
        alertTV.reloadData()
        // 토큰 저장
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
        print("FCM 데이터가 들어오지 않았습니다.")
        
    }
}

