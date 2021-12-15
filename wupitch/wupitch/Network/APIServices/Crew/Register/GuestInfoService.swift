//
//  GuestInfoService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/07.
//

import Foundation
import Alamofire

struct GuestInfoService {
    static let shared = GuestInfoService()

    func getGuestInfo(delegate: CrewApplicationVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        let urlString : String
        
//        if let clubId = UserDefaults.standard.string(forKey: "clubID") {
//            urlString = "https://dev.yogiyo-backend.shop/app/clubs/\(clubId)/guest-info"
//        }
//        else {
//            urlString = "https://dev.yogiyo-backend.shop/app/clubs"
//        }
        
        if let clubId = UserDefaults.standard.string(forKey: "clubID") {
            urlString = "https://prod.wupitch.site/app/clubs/\(clubId)/guest-info"
        }
        else {
            urlString = "https://prod.wupitch.site/app/clubs"
        }
        
        AF.request(urlString, method: .get, encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets), headers: header)
            .responseDecodable(of: GuestInfoData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("손님으로 참여 정보 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessGuestInfo(result: response.result)
                case .failure(let error):
                    print("손님으로 참여 정보에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
