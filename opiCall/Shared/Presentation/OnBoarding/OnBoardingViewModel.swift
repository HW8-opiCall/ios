//
//  OnBoardingViewModel.swift
//  opiCall (iOS)
//
//  Created by Min Jae Lee on 2021-11-20.
//

import Foundation

class OnBoardingViewModel: ObservableObject {
    struct OnBoardingPageData {
        let id: Int
        let title: String
        let description: String
        let imageName: String
    }
    
    @Published var onBoardingPageList: [OnBoardingPageData] = [
        OnBoardingPageData(id: 1, title: "YOUR LIFE MATTERS", description: "The Good Samartian Drug Overdose Act can protect you even if you have taken drugs or have some on you.", imageName: "OnBoarding1"),
        OnBoardingPageData(id: 2, title: "NARCAN SAVES LIVES", description: "PEEL, PLACE, PRESS\nNaloxone can reverse the effects of any opioids", imageName: "OnBoarding2"),
        OnBoardingPageData(id: 3, title: "FULLY INCOGINTO", description: "We won't collect your personal information.", imageName: "OnBoarding3")
    ]
    
    @Published var currentTab = 1
}
