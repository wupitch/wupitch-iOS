//
//  AppleLoginService.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/31.
//

import Foundation
import Alamofire

struct AppleLoginService {
    static let shared = AppleLoginService()
    
    let url = "https://prod.wupitch.site/app/accounts/apple"
    
    func postKakaoLogin(_ parameters: AppleLoginRequest, delegate: OnbordingVC) {
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["Content-Type":"application/json"])
            .responseDecodable(of: AppleLoginData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    print("이거나오면 여기까진온거야")
                    print("여기에도 값을 보여줘",response.result)
                    delegate.didSuccessAppleLogin(result: response.result)
                    print("성공햇니",response)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
