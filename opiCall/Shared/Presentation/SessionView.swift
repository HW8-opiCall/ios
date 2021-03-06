//
//  SessionView.swift
//  opiCall (iOS)
//
//  Created by Min Jae Lee on 2021-11-20.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

class TimerManager: ObservableObject {
    @Published var isTimerRunning = false
    @Published var timeRemaining: Int = 10
    @Published var timer = Timer()
    @Published var check = false
    @Published var test = false
    
    @Published var userResponseTimer = Timer()
    @Published var userWaitingTime = 10
    
    var appManager: AppManager?
    
    func setup(_ appManager: AppManager) {
        self.appManager = appManager
    }
    
    private func initTimer() {
        self.timeRemaining = 5
    }
    
    private func initUserWaitingTimer() {
        self.userWaitingTime = 10
    }
    
    private func startTimer() {
        self.check = false
        self.isTimerRunning = true
        self.appManager?.barType = .Emergency
        self.initUserWaitingTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timeRemaining in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else if self.timeRemaining == 0 {
                self.appManager?.barType = .None
                self.isTimerRunning = false
                self.check = true
                self.startUserAlertTimer()
                self.pauseTimer()
                return
            }
        }
    }
    
    func startUserAlertTimer() {
        self.userResponseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            userWaitingTime in
            if self.userWaitingTime > 0 {
                self.userWaitingTime -= 1
            } else if self.userWaitingTime == 0 {
                self.appManager?.alert = true
                self.userResponseTimer.invalidate()
                self.initUserWaitingTimer()
                self.appManager?.barType = .Tap
            }
        }
    }
    
    func pauseTimer() {
        self.isTimerRunning = false
        timer.invalidate()
    }
    
    func stopTimer() {
        pauseTimer()
        initTimer()
    }
    
    func toggleTimer() {
        if self.isTimerRunning {
            self.pauseTimer()
            self.appManager?.barType = .Tap
        } else {
            self.startTimer()
            self.appManager?.barType = .Emergency
        }
    }
    
    func getTimeString() -> String {
        let mins = timeRemaining / 60 % 60
        let secs = timeRemaining % 60
        return String(format: "%02i:%02i", mins, secs)
    }
    
    func toggleCheck() {
        self.check.toggle()
    }
    
    func extendTime() {
        self.toggleCheck()
        self.stopTimer()
        self.startTimer()
    }
    
    func startTest() {
        self.userResponseTimer.invalidate()
        self.initUserWaitingTimer()
        self.appManager?.barType = .None
        self.stopTimer()
        self.test = true
        self.check = false
    }
    
    func endTest() {
        self.test = false
        self.appManager?.barType = .Tap
    }
}

struct SessionView: View {
    @EnvironmentObject var timerManager: TimerManager
    @EnvironmentObject var appManager: AppManager

    var body: some View {
        ZStack {
            Color.black
                .opacity(0.9)
                .edgesIgnoringSafeArea(.all)
            
            if self.timerManager.test {
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Do you have any of these symptoms?")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.vertical)
                        
                        HStack {
                            Image(systemName: "mouth")
                                .foregroundColor(.white)
                                .frame(width: screenWidth * 0.05)
                            
                            Text("Blue lips or nails")
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        
                        HStack {
                            Image(systemName: "brain.head.profile")
                                .foregroundColor(.white)
                                .frame(width: screenWidth * 0.05)
                            
                            Text("Dizziness and confusion")
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        
                        HStack {
                            Image(systemName: "person.wave.2")
                                .foregroundColor(.white)
                                .frame(width: screenWidth * 0.05)
                            
                            Text("Choking or coughing")
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        
                        HStack {
                            Image(systemName: "thermometer.snowflake")
                                .foregroundColor(.white)
                                .frame(width: screenWidth * 0.05)
                            
                            Text("Cold or clammy skin")
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        
                        HStack {
                            Image(systemName: "eye")
                                .foregroundColor(.white)
                                .frame(width: screenWidth * 0.05)
                            
                            Text("Extremely small pupils")
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            self.timerManager.endTest()
                        }) {
                            Text("No")
                                .foregroundColor(.white)
                                .font(.title)
                                .lineLimit(1)
                                .minimumScaleFactor(0.3)
                                .frame(width: screenWidth * 0.23, height: screenWidth * 0.23)
                                .background(Circle().foregroundColor(.red.opacity(0.95)))
                                .animation(.easeInOut, value: 1)
                        }
                        Spacer()
                        Button(action: {
                            self.timerManager.endTest()
                            self.appManager.alert = true
                        }) {
                            Text("Yes")
                                .foregroundColor(.white)
                                .font(.title)
                                .lineLimit(1)
                                .minimumScaleFactor(0.3)
                                .frame(width: screenWidth * 0.23, height: screenWidth * 0.23)
                                .background(Circle().foregroundColor(.green.opacity(0.95)))
                                .animation(.easeInOut, value: 1)
                        }
                    }
                    .frame(width: screenWidth * 0.8)
                    .padding()
                    .padding()
                }
            } else {
                VStack(spacing: 0) {
                    if !self.timerManager.check {
                        Spacer()
                        Button(action: {
                            self.timerManager.toggleTimer()
                        }) {
                            HStack {
                                Image(systemName: "timer")
                                    .foregroundColor(.white)
                                    .font(.title)
                                
                                Text(self.timerManager.getTimeString())
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                            .frame(width: screenWidth * 0.8, height: screenWidth * 0.8)
                            .clipShape(Circle())
                            .background(
                                Circle()
                                    .strokeBorder(Color.orange.opacity(0.95), lineWidth: 3)
                                    .frame(width: screenWidth * 0.8, height: screenWidth * 0.8)
                            )
                        }
                    } else {
                        Text("Do you want to extend time?")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    if self.timerManager.check {
                        Spacer()
                        
                        Text(String(format: "%02i", self.timerManager.userWaitingTime))
                            .foregroundColor(.red)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Spacer()
                    } else {
                        Spacer()
                    }
                    
                    if self.timerManager.check {
                        HStack {
                            Button(action: {
                                self.timerManager.startTest()
                            }) {
                                Text("No")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.3)
                                    .frame(width: screenWidth * 0.23, height: screenWidth * 0.23)
                                    .background(Circle().foregroundColor(.red.opacity(0.95)))
                                    .animation(.easeInOut, value: 1)
                            }
                            Spacer()
                            Button(action: {
                                self.timerManager.extendTime()
                                self.timerManager.userResponseTimer.invalidate()
                            }) {
                                Text("Yes")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.3)
                                    .frame(width: screenWidth * 0.23, height: screenWidth * 0.23)
                                    .background(Circle().foregroundColor(.green.opacity(0.95)))
                                    .animation(.easeInOut, value: 1)
                            }
                        }
                        .frame(width: screenWidth * 0.8)
                        .padding()
                        .padding()
                    }
                }
                
            }
        }
        .navigationBarHidden(true)
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(containedViewType: .session)
    }
}
