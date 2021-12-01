//
//  PeopleInfoService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import Foundation
import Alamofire


struct MemberInfoService {
    static let shared = MemberInfoService()
    
    let url = "https://prod.wupitch.site/app/accounts/auth"
    
    func getMemberInfo(delegate: ProfileVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: MemberInfoData.self) { response in
                print("마이 페이지의 현재 인증된 회원 정보를 요청 response",response)

                switch response.result {
                case .success(let response):
                    delegate.didSuccessMemberInfo(result: response.result)
                case .failure(let error):
                    print("마이 페이지의 현재 인증된 회원 정보를 요청에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
