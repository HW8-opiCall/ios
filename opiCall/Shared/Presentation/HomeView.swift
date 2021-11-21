//
//  HomeView.swift
//  opiCall (iOS)
//
//  Created by Min Jae Lee on 2021-11-20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                        
                        VStack(alignment: .leading) {
                            Text("Welcome, whitetiger")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            Text("How are you doing?")
                        }
                    }
                    
                    Divider()
                }
         
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Helpful Webpages")
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Button(action: {
                                    if let url = URL(string: "https://www.ontario.ca/page/where-get-free-naloxone-kit") {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Image(systemName: "mappin.and.ellipse")
                                            .padding(.bottom)
                                            .font(.headline)
                                        Text("Naloxone")
                                        Text("Free Kit Map")
                                    }
                                    .mainButton()
                                }
                                .padding(.leading)
                                
                                Button(action: {
                                    if let url = URL(string: "https://www.youtube.com/watch?v=tGdUFMrCRh4") {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Image(systemName: "cross.case")
                                            .padding(.bottom)
                                            .font(.headline)
                                        
                                        Text("How to use")
                                        Text("Narcan")
                                    }
                                    .mainButton()
                                }
                                .padding(.leading)
                                
                                Button(action: {
                                    if let url = URL(string: "https://health.canada.ca/en/health-canada/services/drugs-medication/opioids/responding-canada-opioid-crisis/map.html") {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Image(systemName: "map")
                                            .padding(.bottom)
                                            .font(.headline)
                                        
                                        Text("Opioid-related")
                                        Text("Places")
                                    }
                                    .mainButton()
                                }
                                .padding(.leading)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    VStack(alignment: .leading) {
                        Text("Helpful Phonecalls")
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Button(action: {
                                    let url: NSURL = URL(string: "TEL://18667970000")! as NSURL
                                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                                }) {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Image(systemName: "cross.case")
                                            .padding(.bottom)
                                            .font(.headline)
                                        Text("Telehealth Ontario")
                                        Text("Registered Nurse")
                                    }
                                    .mainButton()
                                }
                                .padding(.leading)
                                
                                Button(action: {
                                    let url: NSURL = URL(string: "TEL://18665312600")! as NSURL
                                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                                }) {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Image(systemName: "cross.case")
                                            .padding(.bottom)
                                            .font(.headline)
                                        
                                        Text("Connex Ontario")
                                        Text("Drug Treatment")
                                    }
                                    .mainButton()
                                }
                                .padding(.leading)
                            }
                        }
                    }
                    .padding(.vertical)

                }
                

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: screenWidth * 0.4, height: screenWidth * 0.4)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.purple.opacity(0.5)))
    }
}

extension View {
    func mainButton() -> some View {
        modifier(ButtonModifier())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(containedViewType: .home)
    }
}
