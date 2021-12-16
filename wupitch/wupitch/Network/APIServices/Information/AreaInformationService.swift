//
//  AreaInformationService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation
import Alamofire

struct AreaInformationService {
    static let shared = AreaInformationService()

    func patchInformation(_ parameters: AreaInformationRequest, delegate: SignUpCityVC) {

        let url = "https://dev.yogiyo-backend.shop/app/accounts/information"
        //let url = "https://prod.wupitch.site/app/accounts/information"

        var header : HTTPHeaders = []
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }

        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .responseDecodable(of: InformationData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("지역 정보 수정 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessInformation(result:response)
                    print("지역 정보 수정 성공했어?",response)
                case .failure(let error):
                    print("지역 정보 수정에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}

