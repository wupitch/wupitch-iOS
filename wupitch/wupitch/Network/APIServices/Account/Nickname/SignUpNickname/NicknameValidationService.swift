//
//  NicknameValidationService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/06.
//

import Foundation
import Alamofire

struct NicknameValidationService {
    static let shared = NicknameValidationService()
    
    let url = "https://dev.yogiyo-backend.shop/app/accounts/nickname/validation"
    //let url = "https://prod.wupitch.site/app/accounts/nickname/validation"
    
    func postNicknameValidation(_ parameters: NicknameValidationRequest, delegate: SignUpProfileVC) {
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["Content-Type":"application/json"])
            .responseDecodable(of: NicknameValidationData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("회원가입 닉네임 중복 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessNicknameValidation(result: response)
                case .failure(let error):
                    print("회원가입 닉네임 중복에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}

