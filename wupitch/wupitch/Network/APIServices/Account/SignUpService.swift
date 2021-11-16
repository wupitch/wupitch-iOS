//
//  SignUpService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/16.
//

import Foundation
import Alamofire

struct SignUpService {
    static let shared = SignUpService()
    
    let url = "https://prod.wupitch.site/app/sign-up"
    
    func postSignUp(_ parameters: SignUpRequest, delegate: SignUpProfileVC) {
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["Content-Type":"application/json"])
            .responseDecodable(of: SignUpData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessSignUp(result: response.result)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가 났습니다.")
                }
            }
    }
}
