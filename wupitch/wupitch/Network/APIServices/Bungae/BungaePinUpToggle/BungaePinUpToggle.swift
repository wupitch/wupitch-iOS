//
//  BungaePinUpToggle.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/01.
//

import Foundation
import Alamofire

struct BungaePinupToggleService {
    static let shared = BungaePinupToggleService()
    
    func patchBungaePinUpToggleService(delegate: BungaeImageCVCell) {
        
        let urlString : String
        
//        if let impromptuId = UserDefaults.standard.string(forKey: "impromptuID") {
//            urlString = "https://prod.wupitch.site/app/impromptus/\(impromptuId)/pinUp-toggle"
//        }
//        else {
//            urlString = "https://prod.wupitch.site/app/impromptus"
//        }
        if let impromptuId = UserDefaults.standard.string(forKey: "impromptuID") {
            urlString = "https://dev.yogiyo-backend.shop/app/impromptus/\(impromptuId)/pinUp-toggle"
        }
        else {
            urlString = "https://dev.yogiyo-backend.shop/app/impromptus"
        }
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(urlString, method: .patch, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: BungaePinUpToggleData.self) { response in
                print("번개 핀업 토글 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessBungaePinUpToggle(result: response.result)
                case .failure(let error):
                    print("번개 핀업 토글에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
