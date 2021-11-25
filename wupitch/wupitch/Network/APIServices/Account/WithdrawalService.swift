//
//  WithdrawalService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/25.
//

import Foundation
import Alamofire

// 회원탈퇴 API
struct WithdrawalService {
    static let shared = WithdrawalService()
    
    let url = "https://prod.wupitch.site/app/accounts/toggle-status"
    
    func patchWithdrawal(delegate: ProfileSettingsVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .patch, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: WithdrawalData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessWithdrawal(result: response)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
