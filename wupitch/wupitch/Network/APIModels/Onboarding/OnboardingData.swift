//
//  OnboardingData.swift
//  wupitch
//
//  Created by 김수정 on 2021/10/17.
//

import Foundation

struct Onboarding {
    let titleLabelName: String
    let descriptionLabelName: String
    let onboardingImageName : String
}

let onboardingData: [Onboarding] = [
    Onboarding(titleLabelName: "내가 원하는 팀 스포츠\n크루를 한 눈에!", descriptionLabelName: "혼자할 수 없는 다양한 크루 스포츠에 가입해보세요.", onboardingImageName: "onbd001"),
    Onboarding(titleLabelName: "자유롭게 만나는\n스포츠 메이트!", descriptionLabelName: "번개를 통해 종목에 상관없이 메이트를 찾아보세요.", onboardingImageName: "onbd002"),
    Onboarding(titleLabelName: "내 활동에서 확인하는\n나의 크루 이야기", descriptionLabelName: "공지사항부터 사진까지 크루 소식을 확인하세요.", onboardingImageName: "onbd003"),
    Onboarding(titleLabelName: "피드를 통해 나누는\n스포츠 정신!", descriptionLabelName: "서로의 스포츠 활동 사진을 공유하세요.", onboardingImageName: "onbd004")
]

