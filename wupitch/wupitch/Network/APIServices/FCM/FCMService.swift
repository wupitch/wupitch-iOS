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
    
    let url = "https://prod.wupitch.site/app/fcms/accounts/auth"
    
    func postFCM(delegate: CrewAlertVC) {
        
        let accessToken = " eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ2aXZpZHN3YW5AbmF2ZXIuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImlhdCI6MTYzNzk1MzE0MiwiZXhwIjoxNjM4Mzg1MTQyfQ.UA6CiyhNauZ6Nektt-gjiIdyYWKf9GMZLtBNppT0d04"
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-ACCESS-TOKEN": accessToken]
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: header)
            .responseDecodable(of: FCMData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessFCM(result: response.result)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
