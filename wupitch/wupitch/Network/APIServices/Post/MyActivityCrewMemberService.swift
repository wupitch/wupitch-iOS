//
//  MyActivityCrewMemberService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/16.
//

import Foundation
import Alamofire
// 내 활동 크루 멤버

struct MyActivityCrewMemberService {
    static let shared = MyActivityCrewMemberService()

    func getMyActivityCrewMember(delegate: MyActivityDetailCrewMemberVC) {

        var header : HTTPHeaders = []
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        let urlString : String
//        if let clubId = UserDefaults.standard.string(forKey: "clubID") {
//            urlString = "https://prod.wupitch.site/app/clubs/\(clubId)/members"
//        }
//        else {
//            urlString = "https://prod.wupitch.site/app/clubs"
//        }
        
        if let clubId = UserDefaults.standard.string(forKey: "clubID") {
            urlString = "https://dev.yogiyo-backend.shop/app/clubs/\(clubId)/members"
        }
        else {
            urlString = "https://dev.yogiyo-backend.shop/app/clubs"
        }
        
        AF.request(urlString, method: .get, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: MyActivityCrewMemberData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("내활동 크루 멤버 조회 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessMyActivityCrewMember(result: response.result)
                case .failure(let error):
                    print("내활동 크루 멤버 조회에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}

