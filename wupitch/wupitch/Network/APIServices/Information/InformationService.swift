//
//  InformationService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/07.
//

import Foundation
import Alamofire

struct InformationService {
    static let shared = InformationService()

    func patchInformation(_ parameters: InformationRequest, delegate: SignUpSportsVC) {

        let url = "https://prod.wupitch.site/app/accounts/information"

        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }

        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .responseDecodable(of: InformationData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("스포츠 정보 수정 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessInformation(result:response)
                    print("스포츠 정보 수정 성공햇니",response)
                case .failure(let error):
                    print("스포츠 정보 수정에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가 났습니다.")
                }
            }
    }
}

