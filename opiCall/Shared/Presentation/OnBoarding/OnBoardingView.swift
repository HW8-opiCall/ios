//
//  OnBoardingView.swift
//  opiCall
//
//  Created by Min Jae Lee on 2021-11-20.
//

import SwiftUI
import FirebaseAuth

struct OnBoardingView: View {
    @AppStorage(AppStorageData.DID_LAUNCH_BEFORE) var didLaunchBefore = false
    @StateObject var onBoardingVM: OnBoardingViewModel = OnBoardingViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: "phone.fill")
                    .font(.title)
                
                Text("opiCall")
                    .font(.title)
                    .fontWeight(.bold)
            }

            
            TabView(selection: self.$onBoardingVM.currentTab,
                    content:  {
                ForEach(self.onBoardingVM.onBoardingPageList, id:\.id)
                {
                    (pageData) in
                    OnBoardingPageView(pageData: pageData)
                }
            })
                .tabViewStyle(PageTabViewStyle())
                            
            HStack {
                ForEach((1...self.onBoardingVM.onBoardingPageList.count), id:\.self) {
                    index in
                    
                    Circle()
                        .foregroundColor(index == self.onBoardingVM.currentTab ? .purple : .white)
                        .overlay(Circle().stroke(Color.primary).frame(width: 10, height: 10))
                        .frame(width: 10, height: 10)
                }
                
                Spacer()
                
                Button(action: {
                    self.didLaunchBefore = true
                }) {
                    if (self.onBoardingVM.currentTab == 3) {
                        Text("GET STARTED")
                            .foregroundColor(.primary)
                    } else {
                        Text("SKIP")
                            .foregroundColor(.primary)
                    }
                }
            }
            .frame(width: screenWidth * 0.8)
            .padding()
        }
        .frame(height: screenHeight * 0.75)
    }
}

struct OnBoardingPageView: View {
    let pageData: OnBoardingViewModel.OnBoardingPageData
    
    var body: some View {
        VStack(alignment: .center) {
            Image(pageData.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth * 0.8, height: screenHeight * 0.4)

            Text(pageData.title)
                .foregroundColor(.primary)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top)
                .padding(.top)
            
            Text(pageData.description)
                .lineLimit(3)
                .minimumScaleFactor(0.5)
                .padding()
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

