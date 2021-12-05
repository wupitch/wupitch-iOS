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
        
        let urlString : String
        
        if let impromptuId = UserDefaults.standard.string(forKey: "impromptuID") {
            urlString = "https://prod.wupitch.site/app/impromptus/\(impromptuId)/participation-toggle"
        }
        else {
            urlString = "https://prod.wupitch.site/app/impromptus"
        }
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(urlString, method: .post, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: BungaeRegisterData.self) { response in
                print("번개 가입하기 버튼 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessBungaeRegister(result: response.result)
                case .failure(let error):
                    print("번개 가입하기 버튼에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}

