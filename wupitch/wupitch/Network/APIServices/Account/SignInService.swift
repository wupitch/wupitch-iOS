//
//  SignInService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/17.
//

import Foundation
import Alamofire

struct SignInService {
    static let shared = SignInService()
    
    let url = "https://dev.yogiyo-backend.shop/app/sign-in"
    //let url = "https://prod.wupitch.site/app/sign-in"
    
    func postSignIn(_ parameters: SignInRequest, delegate: SignInVC) {
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["Content-Type":"application/json"])
            .responseDecodable(of: SignInData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("로그인 response",response)
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessSignIn(result: result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2021: delegate.failedToRequest(message: "이메일 형식을 확인해주세요.")
                        case 2026: delegate.failedToRequest(message: "비밀번호 형식을 확인해주세요.")
                        case 3013: delegate.failedToRequest(message: "없는 아이디이거나 비밀번호가 틀렸습니다.")
                        default: delegate.failedToRequest(message: "이메일과 비밀번호를 다시 확인해주세요.")
                        }
                    }
                case .failure(let error):
                    print("로그인 에러났다",error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
