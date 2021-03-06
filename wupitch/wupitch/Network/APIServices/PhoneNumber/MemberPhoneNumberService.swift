//
//  PhoneNumberService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation
import Alamofire

struct MemberPhoneNumberService {
    static let shared = MemberPhoneNumberService()
    
    let url = "https://dev.yogiyo-backend.shop/app/accounts/auth/phoneNumber"
    //let url = "https://prod.wupitch.site/app/accounts/auth/phoneNumber"
    
    func getMemberPhoneNumber(delegate: SignUpPhoneVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: MemberPhoneNumberData.self) { response in
                print("회원 폰 번호 조회 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessMemberPhoneNumber(result: response.result)
                case .failure(let error):
                    print("회원 폰 번호 조회에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
