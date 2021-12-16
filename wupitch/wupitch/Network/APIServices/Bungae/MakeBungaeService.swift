//
//  MakeBungaeService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import Foundation
import Alamofire

struct MakeBungaeService {
    static let shared = MakeBungaeService()
    
    let url = "https://dev.yogiyo-backend.shop/app/impromptus"
    //let url = "https://prod.wupitch.site/app/impromptus"
    
    func postMakeBungae(_ parameters: MakeBungaeRequest, delegate: MakeBungaeMoneyVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .responseDecodable(of: MakeBungaeData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("번개 생성하기 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessMakeBungae(result: response.result)
                case .failure(let error):
                    print("번개 생성하기에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
