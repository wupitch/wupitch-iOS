//
//  MyActivityBungaeService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/17.
//

import Foundation
import Alamofire

struct MyActivityBungaeService {
    static let shared = MyActivityBungaeService()

    func getMyActivityBungae(delegate: MyActivityBungaeIntroductionVC) {

        let urlString : String
//        if let impromptuId = UserDefaults.standard.string(forKey: "impromptuID") {
//            urlString = "https://prod.wupitch.site/app/impromptus/\(impromptuId)"
//        }
//        else {
//            urlString = "https://prod.wupitch.site/app/impromptus"
//        }
        
        if let impromptuId = UserDefaults.standard.string(forKey: "impromptuID") {
            urlString = "https://dev.yogiyo-backend.shop/app/impromptus/\(impromptuId)"
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
                           delegate.didSuccessMyActivityBungae(result: data)
                       case .failure(let error):
                           print("번개 디테일에서 오류가 났습니다",error.localizedDescription)
                           delegate.failedToRequest(message: "오류가났습니다.")
                       }
                   }
    }
}

