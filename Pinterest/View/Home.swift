//
//  Home.swift
//  Pinterest
//
//  Created by Harpreet Singh on 13/01/26.
//

import SwiftUI

struct Home: View {
    var window = NSScreen.main?.visibleFrame
    
    var body: some View {
        HStack {
            
            SideBar()
            
            Spacer()
        }
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: (window?.width ?? 400) / 1.5,
               height: (window?.height ?? 400) - 50)
        .background(Color.white.opacity(0.6))
        .background(BlurWindow())
    }
}

struct SideBar: View {
    
    @State var selected: String = "Home"
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 22) {
               
                Group {
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
                    
                    HStack {
                        Text("Insights")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.gray)
                        
                        Spacer()
                        
                    }.padding()
                    
                    TabButton(image: "message.fill",
                              title: "Messages",
                              selected: $selected,
                              animation: animation)
                    TabButton(image: "bell.fill",
                              title: "Notifications",
                              selected: $selected,
                              animation: animation)
                    
                }
                
                Spacer(minLength: 0)
                
                VStack(spacing: 8) {
                        Image("business")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Button {
                        
                    } label: {
                        Text("Unlock Business Tools")
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("Hurry! Up Now you can unlock our business tools at your convinence.")
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 10)

                }
                
                Spacer(minLength: 0)
                
                //Profile View
                
                HStack(spacing: 10) {
                    
                    Image("profile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text("Harpreet")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        Text("Last login 2 days ago")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    })
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                       
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 8)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            
            Divider()
                .offset(x: -2)
        }
        //Side bar default size
        .frame(width: 240)
    }
}


#Preview {
    Home()
}
