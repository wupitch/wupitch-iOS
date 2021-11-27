//
//  PasswordCheckService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import Foundation
import Alamofire

struct PasswordCheckService {
    static let shared = PasswordCheckService()
    
    let url = "https://prod.wupitch.site/app/accounts/auth/password/check"
    
    func postPasswordCheck(_ parameters: PasswordCheckRequest, delegate: ProfilePasswordVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
//                            .responseString(completionHandler: { response in
//                                print("response",response.result)
//                                                }
            .responseDecodable(of: PasswordCheckData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessPasswordCheck(result: response)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가 났습니다.")
                }
            }
//        )
    }
}
