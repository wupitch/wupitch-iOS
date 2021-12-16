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
        guard let cell = self.alertTV?.dequeueReusableCell(withIdentifier: CrewAlertCell.identifier, for: indexPath) as? CrewAlertCell else { return UITableViewCell()
        }
        cell.titleLabel.text = fcmData?[indexPath.row].contents
        cell.dateLabel.text = nowDateFormatter(dateLabel: cell.dateLabel.text ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(fcmData?[indexPath.row].fcmID, forKey: "fcmID")
        
        let url : String
        url = "https://dev.yogiyo-backend.shop/app/fcms/\(UserDefaults.standard.integer(forKey: "fcmID"))/view"
        //url = "https://prod.wupitch.site/app/fcms/\(UserDefaults.standard.integer(forKey: "fcmID"))/view"
        
        var header : HTTPHeaders = []
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        AF.request(url, method: .patch, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: PatchFCMData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("fcm 조회 response",response)
                switch response.result {
                case .success(let response):
                    if response.isSuccess == true {
                        // 여기에 눌렀을 때 테이블뷰 셀 색상 변경해주기
                    }
                    else {
                        print("isSuccess가 false입니다.")
                    }
                case .failure(let error):
                    print("fcm 조회에서 오류가 났습니다",error.localizedDescription)
                    
                }
                
            }
    }
        
}


// FCM api 연결
extension CrewAlertVC {
    func didSuccessFCM(result: [FCMResult]) {
        print("FCM 데이터가 성공적으로 들어왔습니다.")
        fcmData = result
        alertTV.reloadData()
        
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
        print("FCM 데이터가 들어오지 않았습니다.")
        
    }
}

