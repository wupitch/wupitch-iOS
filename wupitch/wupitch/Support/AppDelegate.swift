//
//  AppDelegate.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/14.
//

import UIKit
import KakaoSDKCommon
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //KakaoSDKCommon.initSDK(appKey: "b587874a0a178d33f63d9dd3a38b35b9")
        
        // 애플 로그인 자격증명 (각 상황에 따라 앱의 시작화면을 설정해주면됌)
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        appleIDProvider.getCredentialState(forUserID: "00000.abcabcabcabc.0000") {
//            (credentialState, error) in
//            switch credentialState {
//            case .authorized:
//                print("authorized")
//                // 이미 증명이 된 경우
//                // The Apple ID credential is valid.
//            case .revoked:
//                print("revoked")
//                // 증명을 취소했을 때
//            case .notFound:
//                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
//                // 증명이 존재하지 않을 경우
//                print("notFound")
//                DispatchQueue.main.async {
//                    // self.window?.rootViewController?.showLoginViewController()
//                }
//            default:
//                break
//            }
//        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

