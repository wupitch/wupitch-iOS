//
//  BungaeMemberService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/17.
//

import Foundation
import Alamofire

// 내 활동 번개 멤버
struct BungaeMemberService {
    static let shared = BungaeMemberService()
    func getBungaeMember(delegate: MyActivityBungaeMemberVC) {

        var header : HTTPHeaders = []
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        let urlString : String
//        if let impromptuId = UserDefaults.standard.string(forKey: "impromptuID") {
//            urlString = "https://prod.wupitch.site/app/impromptus/\(impromptuId)/members"
//        }
//        else {
//            urlString = "https://prod.wupitch.site/app/impromptus"
//        }
        
        if let impromptuId = UserDefaults.standard.string(forKey: "impromptuID") {
            urlString = "https://dev.yogiyo-backend.shop/app/impromptus/\(impromptuId)/members"
        }
        else {
            urlString = "https://dev.yogiyo-backend.shop/app/impromptus"
        }
        
        AF.request(urlString, method: .get, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: BungaeMemberData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("내활동 번개 멤버 조회 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessBungaeMember(result: response.result)
                case .failure(let error):
                    print("내활동 번개 멤버 조회에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}

