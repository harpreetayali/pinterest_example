//
//  Home.swift
//  Pinterest
//
//  Created by Harpreet Singh on 13/01/26.
//

import SwiftUI

struct Home: View {
    var window = NSScreen.main?.visibleFrame
    @State var selected: String = "Home"
    @Namespace var animation
    var body: some View {
        HStack {
            HStack {
                VStack(spacing: 22) {
                    HStack {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                        
                        Text("Pinterest")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        Spacer(minLength: 0)
                            
                    }
                    .padding(.top)
                    .padding(.leading)
                    
                    //Tab buttons
                    TabButton(image: "house.fill",
                              title: "Home",
                              selected: $selected,
                              animation: animation)
                    
                    TabButton(image: "clock.fill",
                              title: "Recents",
                              selected: $selected,
                              animation: animation)
                    
                    TabButton(image: "person.2.fill",
                              title: "Following",
                              selected: $selected,
                              animation: animation)
                    
                    Spacer()
                }
            }
            //Side bar default size
            .frame(width: 220)
            
            Spacer()
        }
        .frame(width: (window?.width ?? 400) / 1.5,
               height: (window?.height ?? 400) - 50)
        .background(Color.white.opacity(0.6))
        .background(BlurWindow())
    }
}

#Preview {
    Home()
}
