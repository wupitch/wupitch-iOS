//
//  MakeCrewService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/17.
//

import Foundation
import Alamofire

struct MakeCrewService {
    static let shared = MakeCrewService()
    
    //let url = " https://dev.yogiyo-backend.shop/app/clubs"
    let url = "https://prod.wupitch.site/app/clubs"
    
    func postMakeCrew(_ parameters: MakeCrewRequest, delegate: MakeCrewGuestVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .responseDecodable(of: MakeCrewData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("크루 만들기 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessMakeCrew(result: response.result)
                case .failure(let error):
                    print("크루 만들기에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
