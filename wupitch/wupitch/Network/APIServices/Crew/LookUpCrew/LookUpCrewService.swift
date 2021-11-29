//
//  LookUpCrewService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/28.
//

import Foundation
import Alamofire

struct LookUpCrewService {
    static let shared = LookUpCrewService()
    
    func getLookUpCrew(request:LookUpCrewRequest, delegate: CrewVC) {
        var status : Bool
        let urlString = "https://prod.wupitch.site/app/clubs"
        
        let accessToken = " eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ2aXZpZHN3YW5AbmF2ZXIuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImlhdCI6MTYzNzk1MzE0MiwiZXhwIjoxNjM4Mzg1MTQyfQ.UA6CiyhNauZ6Nektt-gjiIdyYWKf9GMZLtBNppT0d04"
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-ACCESS-TOKEN": accessToken,
        ]
        
        var parameters: Parameters = [:]
        
        if request.isAsc == true && request.sportsList == [-1] && request.size == 10 && request.sortBy == "updatedAt" && request.page == -1 && request.memberCountValue == -1 && request.days == [-1] && request.areaId == -1 && request.ageList == [-1] {
            status = false
        }
        else {
            status = true
        }
        
        parameters = [
            "ageList": request.ageList,
            "areaId": request.areaId,
            "days": request.days,
            "isAsc": request.isAsc,
            "memberCountValue": request.memberCountValue,
            "page": request.page,
            "size": request.size,
            "sortBy": request.sortBy,
            "sportsList": request.sportsList
        ]
    
        // Http Method: GET
        AF.request(urlString,
                   method: .get,
                   parameters: status ? parameters : nil,
                   encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets),
                   headers: header).responseDecodable(of: GenericResponse<LookUpCrewDataResult>.self
                   ) { response in
                       print("response",response.result)
                       switch response.result {
                       case .success(let response):
                           print("리스폰즈",response)
                           guard let data = response.result else {return}
                           print("나오니?")
                           delegate.didSuccessLookUpCrew(result: data)
                       case .failure(let error):
                           print("오류가 났습니다",error.localizedDescription)
                           delegate.failedToRequest(message: "오류가났습니다.")
                       }
                   }
    }
}
