//
//  LookUpBoardService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/15.
//

import Foundation
import Alamofire
// 크루 게시판 조회
struct LookUpBoardService {
    static let shared = LookUpBoardService()

    func getLookUpBoard(delegate: MyActivityDetailBoardVC) {

        let urlString : String

//        if let clubId = UserDefaults.standard.string(forKey: "clubID") {
//            urlString = "https://prod.wupitch.site/app/posts/crew/\(clubId)"
//        }
//        else {
//            urlString = "https://prod.wupitch.site/app/posts/crew"
//        }

        if let clubId = UserDefaults.standard.string(forKey: "clubID") {
            urlString = "https://dev.yogiyo-backend.shop/app/posts/crew/\(clubId)"
        }
        else {
            urlString = "https://dev.yogiyo-backend.shop/app/posts/crew"
        }

        var header : HTTPHeaders = []

        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }

        AF.request(urlString, method: .get, encoding: URLEncoding.default, headers: header)
            .responseDecodable(of: LookUpBoardData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("게시판 크루 조회 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessLookUpBoard(result: response.result)
                case .failure(let error):
                    print("게시판 크루 조회에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
