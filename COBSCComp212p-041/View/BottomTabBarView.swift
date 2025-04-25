//
//  BottomTabBarView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2024-10-30.
//

import SwiftUI

struct BottomTabBarView: View {
    @State var currentTab: Tab = .Home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack{
            TabView(selection: $currentTab,
                    content:  {
                TreatmentHomeView()
                    .tag(Tab.Home)
                AppointmentHomeView()
                    .tag(Tab.CreateTickets)
                AppointmentView()
                    .tag(Tab.History)
//                ProfileView()
//                    .tag(Tab.Profile)

            })
            .navigationBarBackButtonHidden(true)
            // Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button(action: {
                        currentTab = tab
                    }) {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                Color("BGBlue")
                                    .opacity(0.2)
                                    .cornerRadius(15)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("BGBlue"): Color.black.opacity(0.4))
                    }
                    
                }
            }
            .padding([.horizontal,.bottom])
            .padding(.top, 20)
            .background(Color("BGBlue").opacity(0.2).clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                .ignoresSafeArea())
           
            

        }
    }
}

#Preview {
    BottomTabBarView()
}
