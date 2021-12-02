//
//  LookUpCrewAreaFilter.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/02.
//

import Foundation
import Alamofire
import UIKit

struct LookUpCrewAreaFiletrService {
    static let shared = LookUpCrewAreaFiletrService()
    
    func getLookUpCrewAreaFilter(delegate: CrewVC) {
        
        let urlString = "https://prod.wupitch.site/app/accounts/auth/crew-filter"
        
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
                   encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets),
                   headers: header).responseDecodable(of: GenericResponse<LookUpCrewFilterResult>.self
                   ) { response in
                       print("response",response.result)
                       switch response.result {
                       case .success(let response):
                           print("크루 지역 필터 조회 리스폰즈",response)
                           guard let data = response.result else {return}
                           print("크루 지역 필터 조회 나오니?")
                           delegate.didSuccessLookUpCrewAreaFilter(result: data)
                       case .failure(let error):
                           print("크루 지역 필터 조회에서 오류가 났습니다",error.localizedDescription)
                           delegate.failedToRequest(message: "오류가났습니다.")
                       }
                   }
    }
}
