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
    
    let url = "https://dev.yogiyo-backend.shop/app/sign-up"
    //let url = "https://prod.wupitch.site/app/sign-up"
    
    func postSignUp(_ parameters: SignUpRequest, delegate: SignUpImagePreviewVC) {
        
        // Http Method: GET
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder(),
                   headers: ["Content-Type":"application/json"]).responseDecodable(of: GenericResponse<SignUpResult>.self
                   ) { response in
                       print("response",response.result)
                       switch response.result {
                       case .success(let response):
                           print("회원가입 리스폰즈",response)
                           guard let data = response.result else {return}
                           print("회원가입 나오니?")
                           delegate.didSuccessSignUp(result: data)
                       case .failure(let error):
                           print("회원가입에서 오류가 났습니다",error.localizedDescription)
                           delegate.failedToRequest(message: "오류가났습니다.")
                       }
                   }
    }
}
