//
//  PatchFcmService.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/01.
//

import Foundation
import Alamofire

// 디바이스 토큰 수정 api
struct PatchFCMService {
    static let shared = PatchFCMService()
    
    let url = "https://prod.wupitch.site/app/device-token"
    
    func patchFCM(_ parameters: PatchFCMRequest, delegate: CrewVC) {
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(url, method: .patch, parameters: parameters.deviceToken, encoder: JSONParameterEncoder(), headers: header)
            .responseDecodable(of: PatchFCMData.self, emptyResponseCodes: [200, 204, 205]) { response in
                print("디바이스 토큰 수정 response",response)
                print("")
                switch response.result {
                case .success(let response):
                    delegate.didSuccessPatchFCM(result: response)
                case .failure(let error):
                    print("디바이스 토큰 수정에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
