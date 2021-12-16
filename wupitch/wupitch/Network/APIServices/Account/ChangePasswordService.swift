//
//  ChangePasswordService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import Foundation
import Alamofire

struct ChangePasswordService {
    static let shared = ChangePasswordService()
    
    let url = "https://dev.yogiyo-backend.shop/app/accounts/auth/password"
    //let url = "https://prod.wupitch.site/app/accounts/auth/password"
    
    func patchChangePassword(_ parameters: ChangePasswordRequest, delegate: ProfilePasswordVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .responseDecodable(of: ChangePasswordData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("변경된 비밀번호 수정 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessChangePassword(result: response)
                case .failure(let error):
                    print("변경된 비밀번호 수정에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가 났습니다.")
                }
            }
    }
}
