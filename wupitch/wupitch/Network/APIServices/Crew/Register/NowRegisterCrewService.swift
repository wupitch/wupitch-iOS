//
//  NowRegisterCrewService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/08.
//

import Foundation
import Alamofire

// 현재 가입한 크루 조회 API -> 내활동 페이지에 들어감
struct NowRegisterCrewService {
    static let shared = NowRegisterCrewService()

    func getNowRegisterCrew(delegate: MyActivityVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        //let urlString = "https://dev.yogiyo-backend.shop/app/clubs/accounts/auth"
        let urlString = "https://prod.wupitch.site/app/clubs/accounts/auth"
        
        AF.request(urlString, method: .get, encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets), headers: header)
            .responseDecodable(of: NowRegisterCrewData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("현재 가입한 크루 정보 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessNowRegister(result: response.result)
                case .failure(let error):
                    print("현재 가입한 크루 정보에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
