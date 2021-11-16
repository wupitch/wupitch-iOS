//
//  PwValidationService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/16.
//

import Foundation
import Alamofire

struct PwValidationService {
    static let shared = PwValidationService()
    
    let url = "https://prod.wupitch.site/app/accounts/password/validation"
    
    func postPwValidation(_ parameters: PwValidationRequest, delegate: SignUpEmailPwVC) {
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["Content-Type":"application/json"])
            .responseDecodable(of: PwValidationData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessPwValidation(result: response)
                    print("성공햇니",response)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToEmailRequest(message: "오류가 났습니다.")
                }
            }
    }
}
