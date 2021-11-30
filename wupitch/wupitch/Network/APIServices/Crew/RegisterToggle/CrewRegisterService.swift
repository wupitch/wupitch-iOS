//
//  CrewRegisterService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation
import UIKit
import Alamofire

// 크루 가입하기 버튼
struct CrewRegisterService {
    static let shared = CrewRegisterService()
    
    func postCrewRegisterService(delegate: CrewDetailVC) {
        
        let clubId = 3
        
        let urlString = "https://prod.wupitch.site/app/clubs/\(clubId)/participation-toggle"
        
        let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0bndqZEB0LnQiLCJyb2xlIjoiUk9MRV9VU0VSIiwiaWF0IjoxNjM4MjU2MjEzLCJleHAiOjE2Mzg2ODgyMTN9.xLwAVhi1EGuTwxodyVOPh_WcITZK-zPHXW6y1YH130g"
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-ACCESS-TOKEN": accessToken,
        ]
        
        AF.request(urlString, method: .post, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: CrewRegisterData.self) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessCrewRegister(result: response)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
