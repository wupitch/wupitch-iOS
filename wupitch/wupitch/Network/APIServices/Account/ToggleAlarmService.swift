//
//  ToggleAlarmService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/26.
//

import Foundation
import Alamofire

// 알림 동의 변경 API
struct ToggleAlarmService {
    static let shared = ToggleAlarmService()
    
    let url = "https://prod.wupitch.site/app/accounts/toggle-alarm-info"
    
    func patchToggleAlarm(delegate: ProfileSettingsVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .patch, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: ToggleAlarmData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("푸시알림 동의 버튼 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessToggleAlarm(result: response)
                case .failure(let error):
                    print("푸시알림 동의 버튼에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
