//
//  MainView.swift
//  opiCall
//
//  Created by Min Jae Lee on 2021-11-20.
//

import SwiftUI
import AVFoundation

enum ContainedViewType {
    case home
    case session
    case profile
}

enum BarType {
    case Tap
    case Emergency
    case None
}

class AppManager: ObservableObject {
    @Published var barType: BarType = .Tap
    @Published var alert: Bool = false
    @Published var alertTimer = Timer()
}

var player: AVAudioPlayer?

struct MainView: View {
    @StateObject var timerManager: TimerManager = TimerManager()
    @State var containedViewType: ContainedViewType = .home
    @StateObject var appManager = AppManager()
    
    func containedView() -> AnyView {
         switch containedViewType {
         case .home: return AnyView(HomeView())
         case .session: return AnyView(SessionView().environmentObject(appManager).environmentObject(timerManager))
         case .profile: return AnyView(ProfileView())
         }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alert", withExtension: "mp3") else {
            print("url not found")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)

            player!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if appManager.alert {
                ZStack {
                    Color.red
                        .ignoresSafeArea(.all)
                    
                    VStack {
                        Text("Overdose Warning")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        Text("Naloxone Required")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("Tap three times to clear warning")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                .onAppear {
                    appManager.alertTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                        timer in
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        playSound()
                    }
                }
                .onTapGesture(count: 3) {
                    appManager.alert = false
                }
                .onDisappear{
                    appManager.alertTimer.invalidate()
                    player?.stop()
                }
            } else {
                containedView()
                            
                switch appManager.barType {
                case .Tap:
                    MainTapBar(containedViewType: $containedViewType)
                case .Emergency:
                    Button(action: {
                        self.appManager.alert = true
                        timerManager.stopTimer()
                    }) {
                        VStack {
                            Text("EMERGENCY")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.black)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.red).shadow(color: .gray.opacity(0.4), radius: 15, x: 0, y: 0))
                    }
                    .padding()
                case .None:
                    EmptyView()
                }
            }
        }
        .onAppear {
            self.timerManager.setup(appManager)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MainTapBar: View {
    @Binding var containedViewType: ContainedViewType
    
    var body: some View {
        HStack (spacing: 60) {
            Button(action: {
                self.containedViewType = .home
            })
            {
                VStack {
                    Image(systemName: "house")
                        .font(.system(size: 26))
                        .foregroundColor(self.containedViewType == .home ? .primary : .secondary)
                }
            }
            
            Button(action: {
                self.containedViewType = .session
            })
            {
                VStack {
                    Image(systemName: "pills")
                        .font(.system(size: 26))
                        .foregroundColor(self.containedViewType == .session ? .white : .white)
                }
            }
            .padding()
            .background(
                Circle()
                    .foregroundColor(.purple)
            )
            
            Button(action: {
                self.containedViewType = .profile
            })
            {
                VStack {
                    Image(systemName: "person")
                        .font(.system(size: 26))
                        .foregroundColor(self.containedViewType == .profile ? .primary : .secondary)
                }
            }
        }
        .padding([.leading, .trailing,.bottom])
        .frame(maxWidth: .infinity)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
