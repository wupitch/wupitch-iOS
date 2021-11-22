//
//  ProfileImageService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/22.
//

//import Foundation
//import Alamofire
//
//struct ProfileImageService {
//    static let shared = ProfileImageService()
//
//    func postMakeCrew(images: UIImage, delegate: SignUpImagePreviewVC) {
//
//        let url = "https://prod.wupitch.site/app/accounts/image"
//
//        var header : HTTPHeaders = []
//
//        if let token = UserDefaults.standard.string(forKey: "userToken") {
//            header = ["Content-Type":"multipart/form-data", "X-ACCESS-TOKEN": token]
//        }
//        else {
//            header = ["Content-Type":"multipart/form-data"]
//        }
//
//
//
//        AF.upload(multipartFormData: { multipartFormData in
//
//            let imageData = images.jpegData(compressionQuality: 1.0)
//
//            multipartFormData(provider: .data(imageData!), name: "imgs", fileName: "image", mimeType: ""image/jpeg")
//
//            multipartFormData.append(imageData!, withName: "images", fileName: "image", mimeType: "image/jpeg")
//            print("이미지 어떻게 나와?",imageData ?? "값없어")
//
//        }, to: url, method: .post, headers: header)
//                            .responseString(completionHandler: { response in
//                                print("response",response.result)
//                                                }
////            .responseDecodable(of: ProfileImageData.self, emptyResponseCodes: [200, 204, 205]) { response in
////            print("response",response)
////            switch response.result {
////            case .success(let response):
////                delegate.didSuccessProfile(result: response)
////            case .failure(let error):
////                print("오류가 났습니다",error.localizedDescription)
////                delegate.failedToRequest(message: "오류가났습니다.")
////            }
////        }
//        )
//    }
//}
