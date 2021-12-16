//
//  BungaeSearchService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/07.
//

import Foundation
import Alamofire
import UIKit

struct BungaeSearchService {
    static let shared = BungaeSearchService()
    
    func getBungaeSearch(keyword: String, delegate: CrewSearchVC) {
        
        let urlString = "https://dev.yogiyo-backend.shop/app/impromptus/title"
        //let urlString = "https://prod.wupitch.site/app/impromptus/title"
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        let params: Parameters = [
            "title" : keyword
        ]
        
        // Http Method: GET
        AF.request(urlString,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets),
                   headers: header).responseDecodable(of: GenericResponse<BungaeSearchResult>.self
                   ) { response in
                       print("response",response.result)
                       switch response.result {
                       case .success(let response):
                           print("번개 검색 조회 리스폰즈",response)
                           guard let data = response.result else {return}
                           print("번개 검색 조회 나오니?")
                           delegate.didSuccessBungaeSearch(result: data)
                       case .failure(let error):
                           print("번개 검색 조회에서 오류가 났습니다",error.localizedDescription)
                           delegate.failedToRequest(message: "오류가났습니다.")
                       }
                   }
    }
}
