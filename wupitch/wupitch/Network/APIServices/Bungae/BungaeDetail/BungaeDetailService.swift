//
//  BungaeDetailService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation
import Alamofire

struct BungaeDetailService {
    static let shared = BungaeDetailService()

    func getBungaeDetail(delegate: BungaeDetailVC) {

        let urlString : String
        
        if let impromptuId = UserDefaults.standard.string(forKey: "impromptuId") {
            urlString = "https://prod.wupitch.site/app/impromptus/\(impromptuId)"
        }
        else {
            urlString = "https://prod.wupitch.site/app/impromptus"
        }
        
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
                   headers: header).responseDecodable(of: GenericResponse<BungaeDetailResult>.self
                   ) { response in
                       print("response",response.result)
                       switch response.result {
                       case .success(let response):
                           print("번개 디테일 리스폰즈",response)
                           guard let data = response.result else {return}
                           print("번개 디테일 나오니?")
                           delegate.didSuccessBungaeDetail(result: data)
                       case .failure(let error):
                           print("번개 디테일에서 오류가 났습니다",error.localizedDescription)
                           delegate.failedToRequest(message: "오류가났습니다.")
                       }
                   }
    }
}

