//
//  PinUpToggleService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/30.
//

import Foundation
import Alamofire

struct PinupToggleService {
    static let shared = PinupToggleService()
    
    func patchPinUpToggleService(delegate: DetailCrewImgTVCell) {
        
        let urlString : String
        
        if let clubId = UserDefaults.standard.string(forKey: "clubID") {
            urlString = "https://prod.wupitch.site/app/clubs/\(clubId)/pinUp-toggle"
        }
        else {
            urlString = "https://prod.wupitch.site/app/clubs"
        }
        
        var header : HTTPHeaders = []
        
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            header = ["Content-Type":"application/json", "X-ACCESS-TOKEN": token]
        }
        else {
            header = ["Content-Type":"application/json"]
        }
        
        AF.request(urlString, method: .patch, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: PinUpToggleData.self) { response in
                print("크루 핀업 토글 response",response)
                switch response.result {
                case .success(let response):
                    delegate.didSuccessPinUpToggle(result: response.result)
                case .failure(let error):
                    print("크루 핀업 토글에서 오류가 났습니다",error.localizedDescription)
                    delegate.failedToRequest(message: "오류가났습니다.")
                }
            }
    }
}
