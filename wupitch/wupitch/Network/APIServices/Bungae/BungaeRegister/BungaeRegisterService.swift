//
//  BungaeRegisterService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/01.
//

import Foundation
import Alamofire

// 크루 가입하기 버튼
struct BungaeRegisterService {
    static let shared = BungaeRegisterService()
    
    func postBungaeRegisterService(delegate: BungaeDetailVC) {
        
        let impromptuId = 4
        
        let urlString = "https://prod.wupitch.site/app/impromptus/\(impromptuId)/participation-toggle"
        
        let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0bndqZEB0LnQiLCJyb2xlIjoiUk9MRV9VU0VSIiwiaWF0IjoxNjM4MjU2MjEzLCJleHAiOjE2Mzg2ODgyMTN9.xLwAVhi1EGuTwxodyVOPh_WcITZK-zPHXW6y1YH130g"
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-ACCESS-TOKEN": accessToken,
        ]
        
        AF.request(urlString, method: .post, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: BungaeRegisterData.self) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessBungaeRegister(result: response.result)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}

