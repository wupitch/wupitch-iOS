//
//  GuestRegisterService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/05.
//

import Foundation
import Alamofire

struct GuestRegisterService {
    static let shared = GuestRegisterService()
    
    //let url = "https://dev.yogiyo-backend.shop/app/clubs/guest-info"
    let url = "https://prod.wupitch.site/app/clubs/guest-info"
    
    func postMakeCrew(_ parameters: GuestRegisterRequest, delegate: CrewApplicationVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .responseDecodable(of: GuestRegisterData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("손님 등록 response",response)
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessGuestRegister(result: response)
                    }
                    // 실패했을 때
                    else {
                        print("손님등록들어와?")
                        switch response.code {
                        case 2014: delegate.failedToRequest(message: "필요한 모든 정보를 입력해주세요.")
                            print("2014")
                        default: delegate.failedToRequest(message: "")
                            print("default")
                        }
                    }
                case .failure(let error):
                    print("손님 등록에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
