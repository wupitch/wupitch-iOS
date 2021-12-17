//
//  LikeBoardService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/15.
//

import Foundation
import Alamofire

// 크루 게시판 좋아요 토글
struct LikeToggleService {
    static let shared = LikeToggleService()

    func patchLikeToggle(delegate: CrewBoardActivityTVCell) {

        var header : HTTPHeaders = []
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        let urlString : String
//        if let postId = UserDefaults.standard.string(forKey: "postID") {
//            urlString = "https://prod.wupitch.site/app/posts/\(postId)/like-toggle"
//        }
//        else {
//            urlString = "https://prod.wupitch.site/app/posts"
//        }
        
        if let postId = UserDefaults.standard.string(forKey: "postID") {
            urlString = "https://dev.yogiyo-backend.shop/app/posts/\(postId)/like-toggle"
        }
        else {
            urlString = "https://dev.yogiyo-backend.shop/app/posts"
        }
        
        AF.request(urlString, method: .patch, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: LikeToggleData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("게시판 좋아요 토글 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessLikeToggle(result: response.result)
                case .failure(let error):
                    print("게시판 좋아요 토글에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}

