//
//  Home.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/2.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State var showContent = false
    @EnvironmentObject var user: UserStore

    var body: some View {
        ZStack {
            Color("background2")
                // 根视图的安全区域颜色设置为全部`.edgesIgnoringSafeArea(.all)`
                .edgesIgnoringSafeArea(.all)
            HomeBackgroundView(showProfile: $showProfile)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: Double(showProfile ? (viewState.height / 10) - 10 : 0)), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)

//            TabView {
                HomeView(showProfile: $showProfile, showContent: $showContent, viewState: $viewState)
//                    .tabItem {
//                        Image(systemName: "play.circle.fill")
//                        Text("主页")
//                    }
//            }
                

            MenuView(showProfile: $showProfile)
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                    }
                    .onEnded { _ in
                        if self.viewState.height > 50 {
                            self.showProfile = false
                        }
                        // 重置
                        self.viewState = .zero
                    }
                )

            //
            if user.showLogin {
                ZStack {
                    LoginView()
                    
                    VStack {
                        HStack {
                            Spacer()

                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                // 前景色
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        self.user.showLogin = false
                    }
                }
            }
            
            // 使用if语句，提高view性能
            if showContent {
                // 在ZHack里面的任何元素将会彼此重叠
                // 设置颜色，忽略安全区
                BlurView(style: .systemMaterial).edgesIgnoringSafeArea(.all)
                ContentView()

                VStack {
                    HStack {
                        Spacer()

                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            // 前景色
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                    self.showContent = false
                }
            }
        }
    }
}

// 在Home这里设置暗黑模式
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
//            .environment(\.colorScheme, .dark)
            // 对于手机用户调整字体大小时。这个设置能自动放大字体大小到合适。
//            .environment(\.sizeCategory, .extraLarge)
            .environmentObject(UserStore())
    }
}

struct AvatarView: View {
    // 共享状态
    @Binding var showProfile: Bool
    // 用户是否登录的图标显示
    @EnvironmentObject var user: UserStore

    var body: some View {
        VStack {
            if user.isLogged {
                Button(action: { self.showProfile.toggle() }) {
                Image("Avatar")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                }
            } else {
                Button(action: { self.user.showLogin.toggle() }) {
                Image(systemName: "person")
                    .foregroundColor(.primary)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 36, height: 36)
                    .background(Color("background3"))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                }
            }
        }
    }
}

// 检测屏幕的尺寸
let screen = UIScreen.main.bounds

struct HomeBackgroundView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
            
            Spacer()
        }
        .background(Color("background1"))
        .clipShape(RoundedRectangle(cornerRadius: showProfile ? 30 : 0, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
    }
}
