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
    
    let url = "https://prod.wupitch.site/app/fcm/test"
    
    func postFCM(_ parameters: FCMRequest, delegate: TabbarVC) {
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["Content-Type":"application/json"])
            .responseDecodable(of: FCMData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessFCM(result: response)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
