//
//  ContentView.swift
//  Shared
//
//  Created by Min Jae Lee on 2021-11-20.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(AppStorageData.DID_LAUNCH_BEFORE) private var didLaunchBefore = false

    var body: some View {
        Group {
            if didLaunchBefore {
                MainView()
            } else {
                OnBoardingView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
