//
//  FCMService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation
import Alamofire

struct FCMService {
    static let shared = FCMService()
    
    let url = "https://dev.yogiyo-backend.shop/app/fcms/accounts/auth"
    //let url = "https://prod.wupitch.site/app/fcms/accounts/auth"
    
    func postFCM(delegate: CrewAlertVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: header)
            .responseDecodable(of: FCMData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("fcm 알림 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessFCM(result: response.result)
                case .failure(let error):
                    print("fcm 알림에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
