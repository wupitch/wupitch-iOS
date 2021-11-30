//
//  LookUpCrewFilterService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation
import Alamofire
import UIKit

struct LookUpCrewFiletrService {
    static let shared = LookUpCrewFiletrService()
    
    func getLookUpCrewFilter(delegate: CrewFilterVC) {
        
        let urlString = "https://prod.wupitch.site/app/accounts/auth/crew-filter"
        
        let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0bndqZEB0LnQiLCJyb2xlIjoiUk9MRV9VU0VSIiwiaWF0IjoxNjM4MjU2MjEzLCJleHAiOjE2Mzg2ODgyMTN9.xLwAVhi1EGuTwxodyVOPh_WcITZK-zPHXW6y1YH130g"
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-ACCESS-TOKEN": accessToken,
        ]
        
        // Http Method: GET
        AF.request(urlString,
                   method: .get,
                   encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets),
                   headers: header).responseDecodable(of: GenericResponse<LookUpCrewFilterResult>.self
                   ) { response in
                       print("response",response.result)
                       switch response.result {
                       case .success(let response):
                           print("리스폰즈",response)
                           guard let data = response.result else {return}
                           print("나오니?")
                           delegate.didSuccessLookUpCrewFilter(result: data)
                       case .failure(let error):
                           print("오류가 났습니다",error.localizedDescription)
                           delegate.failedToRequest(message: "오류가났습니다.")
                       }
                   }
    }
}
