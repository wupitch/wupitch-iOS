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
        
        let urlString : String
                
        if let clubId = UserDefaults.standard.string(forKey: "clubId") {
            urlString = "https://prod.wupitch.site/app/clubs/\(clubId)/participation-toggle"
        }
        else {
            urlString = "https://prod.wupitch.site/app/clubs"
        }
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(urlString, method: .post, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: CrewRegisterData.self) { response in
                print("크루 가입하기 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessCrewRegister(result: response)
                case .failure(let error):
                    print("크루 가입하기에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
