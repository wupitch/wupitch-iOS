//
//  MakeBoardService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/15.
//

import Foundation
import Alamofire

// 내활동 크루 게시판 글 생성
struct MakeBoardService {
    static let shared = MakeBoardService()

    func postMakeBoard(_ parameters: MakeBoardRequest, delegate: AddBoardVC) {

        var header : HTTPHeaders = []
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
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
        
        AF.request(urlString, method: .post, parameters: parameters,
                   encoder: JSONParameterEncoder(), headers: header)
            .responseDecodable(of: MakeBoardData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("게시판 글 생성 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessMakeBoard(result: response)
                case .failure(let error):
                    print("게시판 글 생성에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
