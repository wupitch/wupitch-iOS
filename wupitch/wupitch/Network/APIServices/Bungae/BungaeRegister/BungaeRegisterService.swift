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
            .responseDecodable(of: GenericResponse<BungaeRegisterResult>.self
            ) { response in
                print("번개 가입하기 버튼 response",response)
                switch response.result {
                case .success(let response):
                    if response.isSuccess {
                    print("번개 가입하기 버튼 리스폰즈",response)
                    guard let data = response.result else {return}
                    print("번개 가입하기 버튼 나오니?")
                    delegate.didSuccessBungaeRegister(result: data.self)
                    }
                    else {
                        switch response.code {
                        case 2014:
                            delegate.failedToRequest(message: "필요한 모든 정보를 입력해주세요.")
                        default:
                            delegate.failedToRequest(message: "")
                        }
                    }
                    
                case .failure(let error):
                    print("번개 가입하기 버튼에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}

