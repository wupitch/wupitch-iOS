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
    Onboarding(titleLabelName: "내가 원하는 팀 스포츠\n크루를 한 눈에!", descriptionLabelName: "지역구를 기반으로 원하는 크루를 찾아보세요.", onboardingImageName: "imgOnbd01"),
    Onboarding(titleLabelName: "번개와 리그를 통해\n함께 운동하세요", descriptionLabelName: "번개모임과 팀 리그를 조직하고 참여하세요.", onboardingImageName: "imgOnbd02"),
    Onboarding(titleLabelName: "내 활동에서 확인하는\n나의 크루 이야기", descriptionLabelName: "공지사항부터 사진까지 크루 소식을 확인하세요.", onboardingImageName: "imgOnbd03"),
    Onboarding(titleLabelName: "피드를 통해 나누는\n스포츠 정신!", descriptionLabelName: "서로의 스포츠 활동 사진을 공유하세요.", onboardingImageName: "imgOnbd04")
]

