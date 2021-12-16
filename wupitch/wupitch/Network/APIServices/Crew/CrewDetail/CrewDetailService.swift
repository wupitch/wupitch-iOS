//
//  CrewDetailService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation
import Alamofire

struct CrewDetailService {
    static let shared = CrewDetailService()

    func getCrewDetail(delegate: CrewDetailVC) {

        var header : HTTPHeaders = []

        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }

        let urlString : String
        
        if let clubId = UserDefaults.standard.string(forKey: "clubID") {
            urlString = "https://dev.yogiyo-backend.shop/app/clubs/\(clubId)"
        }
        else {
            urlString = "https://dev.yogiyo-backend.shop/app/clubs"
        }
        
//        if let clubId = UserDefaults.standard.string(forKey: "clubID") {
//            urlString = "https://prod.wupitch.site/app/clubs/\(clubId)"
//        }
//        else {
//            urlString = "https://prod.wupitch.site/app/clubs"
//        }

        // Http Method: GET
        AF.request(urlString,
                   method: .get,
                   encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets),
                   headers: header).responseDecodable(of: GenericResponse<CrewDetailResult>.self
                   ) { response in
                       print("크루 디테일 response",response.result)
                       switch response.result {
                       case .success(let response):
                           print("크루 디테일 리스폰즈",response)
                           guard let data = response.result else {return}
                           print("크루 디테일 나오니?")
                           delegate.didSuccessCrewDetail(result: data)
                       case .failure(let error):
                           print("크루디테일이 오류가 났습니다",error.localizedDescription)
                           delegate.failedToRequest(message: "오류가났습니다.")
                       }
                   }
    }
}

