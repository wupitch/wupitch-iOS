//
//  MakeCrewImageService.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/27.
//

import Foundation
import Alamofire

struct MakeCrewImageService {
//    static let shared = MakeCrewImageService()
//    
//    let url = "https://prod.wupitch.site/app/clubs/image"
//    
//    func postMakeCrew(_ parameters: MakeCrewRequest, delegate: MakeCrewGuestVC) {
//        
//        var header : HTTPHeaders = []
//        
//        if let token = UserDefaults.standard.string(forKey: "userToken") {
//            header = ["Content-Type":"multipart/form-data", "X-ACCESS-TOKEN": token]
//        }
//        
//        let userImage = self.imagePrevieImageView?.image
//        
//        AF.upload(
//            multipartFormData: { MultipartFormData in
//                if((userImage) != nil){
//                    MultipartFormData.append(userImage!.jpegData(compressionQuality: 0.025)!, withName: "images", fileName: "imageNew.jpeg", mimeType: "image/jpeg")
//                    print("사진 잘 들어오나 확인 >>>>>", userImage!)
//                }
//            }, to: url, method: .patch, headers: header).uploadProgress(queue: .main) { progress in
//                
//                print("Upload Progress: \(progress.fractionCompleted)")
//            }.responseJSON { data in
//                switch data.result {
//                case .success(let response):
//                    print("데이터가 성공적으로 들어왔어요", response)
//                    
//                    //버튼 클릭 시, 다음 스토리보드로 이동
//                    let storyboard = UIStoryboard.init(name: "SignUpComplete", bundle: nil)
//                    guard let dvc = storyboard.instantiateViewController(identifier: "SignUpCompleteVC") as? SignUpCompleteVC else {return}
//                    self.tabBarController?.tabBar.isHidden = true
//                    self.navigationController?.pushViewController(dvc, animated: true)
//                    
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//    }
}
