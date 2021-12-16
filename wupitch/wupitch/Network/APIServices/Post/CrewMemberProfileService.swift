//
//  CrewMemberProfileService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/17.
//

import Foundation
import Alamofire

// 내활동 크루 멤버 프로필
struct CrewMemberProfileService {
    static let shared = CrewMemberProfileService()

    func getCrewMemberProfile(delegate: BungaeMemberDetailVC) {

        var header : HTTPHeaders = []
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        let urlString : String
//        if let clubId = UserDefaults.standard.string(forKey: "clubID"),
//        let accountId = UserDefaults.standard.string(forKey: "accountID") {
//            urlString = "https://prod.wupitch.site/app/clubs/\(clubId)/accounts/\(accountId)/profile-info"
//        }
//        else {
//            urlString = "https://prod.wupitch.site/app/clubs"
//        }
        
        if let clubId = UserDefaults.standard.string(forKey: "clubID"),
            let accountId = UserDefaults.standard.string(forKey: "accountID") {
            urlString = "https://dev.yogiyo-backend.shop/app/clubs/\(clubId)/accounts/\(accountId)/profile-info"
        }
        else {
            urlString = "https://dev.yogiyo-backend.shop/app/clubs"
        }
        
        AF.request(urlString, method: .get, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: CrewMemberProfileData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("내활동 크루 멤버 프로필 조회 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessCrewMemberProfile(result: response.result)
                case .failure(let error):
                    print("내활동 크루 멤버 프로필 조회에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}

