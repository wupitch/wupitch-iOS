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

//        var header : HTTPHeaders = []
//
//        if let token = UserDefaults.standard.string(forKey: "userToken") {
//            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
//        }
//        else {
//            header = ["Content-Type":"application/json"]
//        }

        var header : HTTPHeaders = []

        let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhYWFAenp6LmRkZCIsInJvbGUiOiJST0xFX1VTRVIiLCJpYXQiOjE2MzgwNDA1ODUsImV4cCI6MTYzODQ3MjU4NX0.nKiwwxOxjwKv0BaNgWVEb_wHIKL_Ey26FzO5vRx0oLY"

        header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]

        let url: String

        let clubId = 1

        //UserDefaults.standard.integer(forKey: "clubId")

        url = "https://prod.wupitch.site/app/clubs/\(clubId)"

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
//                            .responseString(completionHandler: { response in
//                                print("response",response.result)
//                                                }
            .responseDecodable(of: CrewDetailData.self) { response in
                print("response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessCrewDetail(result: response.result)
                case .failure(let error):
                    print("오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
//        )
    }
}
