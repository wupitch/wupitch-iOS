//
//  LookUpBungaeService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation
import Alamofire
import UIKit

struct LookUpBungeService {
    static let shared = LookUpBungeService()
    
    func getLookUpBunge(params: [String:[Any]]?, delegate: BungaeVC) {
        
        let urlString = "https://prod.wupitch.site/app/impromptus"
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        // Http Method: GET
        AF.request(urlString,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets),
                   headers: header).responseDecodable(of: GenericResponse<LookUpBungaeResult>.self
                   ) { response in
                       print("번개 조회 response",response.result)
                       switch response.result {
                       case .success(let response):
                           print("번개 조회 리스폰즈",response)
                           guard let data = response.result else {return}
                           print("번개 조회 나오니?")
                           delegate.didSuccessLookUpBungae(result: data)
                       case .failure(let error):
                           print("번개 조회에서 오류가 났습니다",error.localizedDescription)
                           delegate.failedToRequest(message: "오류가났습니다.")
                       }
                   }
    }
}
