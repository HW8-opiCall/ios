//
//  ProfileView.swift
//  opiCall (iOS)
//
//  Created by Min Jae Lee on 2021-11-20.
//

import SwiftUI

struct ProfileView: View {
    @State var call911 = true
    @State var callContact = true
    @State var notifyFriendsYes = true
    @State var notifyFriendsNo = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Profile")
                        .foregroundColor(.primary)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding()
                    
                    Divider()
                }
                .background(Color(UIColor.systemBackground))
                
                VStack {
                    Form {
                        
                        Section {
                            NavigationLink(destination: SettingsView()) {
                                Text("Go to Settings")
                            }
                        }
                        
                        Section {
                            Text("Emergency Contacts")
                            
                        }

                    }
                }
                
                Spacer()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}


struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(AppStorageData.yesNaloxone) var yesNaloxone = false
    @AppStorage(AppStorageData.noNaloxone) var noNaloxone = true
    @AppStorage(AppStorageData.call911) var call911 = true
    @AppStorage(AppStorageData.callContact) var callContact = true
    @AppStorage(AppStorageData.notifyFirendsYes) var notifyFriendsYes = true
    @AppStorage(AppStorageData.notifyFirendsNo) var notifyFriendsNo = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Settings")
                        .foregroundColor(.primary)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing)
                }
                .padding()
                
                Divider()
            }
            .background(Color(UIColor.systemBackground))
            
            ScrollView {
                VStack {
                    QuestionBox(condition: "I have a Naloxone", question: "", optionLeft: "Yes", optionRight: "No", canBoth: false, chooseLeft: $yesNaloxone, chooseRight: $noNaloxone)
                    
                    QuestionBox(condition: "When you do not respond,", question: "Where should we contact for you?", optionLeft: "911", optionRight: "Emergency\nContact", canBoth: true, chooseLeft: $call911, chooseRight: $callContact)
                    
                    QuestionBox(condition: "When you start session,", question: "Should we notify your friends?", optionLeft: "Yes", optionRight: "No", canBoth: false, chooseLeft: $notifyFriendsYes, chooseRight: $notifyFriendsNo)
                }
            }
            
            Spacer()
        }
        .background(Color(UIColor.secondarySystemBackground))
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct QuestionBox: View {
    let condition: String
    let question: String
    let optionLeft: String
    let optionRight: String
    let canBoth: Bool
    @Binding var chooseLeft: Bool
    @Binding var chooseRight: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(condition)
            
            Text(question)
            
            HStack {
                Button(action: {
                    if canBoth {
                        self.chooseLeft.toggle()
                    } else if chooseLeft == false {
                        self.chooseLeft = true
                        self.chooseRight = false
                    }
                }) {
                    Text(optionLeft)
                        .foregroundColor(chooseLeft ? .white : .primary)
                        .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                        .background {
                            if chooseLeft {
                                RoundedRectangle(cornerRadius: 10).foregroundColor(.purple)
                            } else {
                                RoundedRectangle(cornerRadius: 10).stroke(Color.purple)
                            }
                        }
                }
            
                Spacer()
                
                Button(action: {
                    if canBoth {
                        self.chooseRight.toggle()
                    } else if chooseRight == false {
                        self.chooseRight = true
                        self.chooseLeft = false
                    }
                }) {
                    VStack {
                        Text(optionRight)
                            .foregroundColor(chooseRight ? .white : .primary)
                            .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                            .background{
                                if chooseRight {
                                    RoundedRectangle(cornerRadius: 10).foregroundColor(.purple)
                                } else {
                                    RoundedRectangle(cornerRadius: 10).stroke(Color.purple)
                                }
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .padding([.horizontal, .top])
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(containedViewType: .profile)
    }
}
