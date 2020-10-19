//
//  TabBar.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/4.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            CourseList().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Courses")
            }
        }
        // 忽略掉安全区域
//            .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        // 不同型号的预览
//        TabBar().previewDevice("iPhone 11 Pro")
        
        Group {
            TabBar().previewDevice("iPhone Xʀ")
            .environmentObject(UserStore())
        //            TabBar().previewDevice("iPhone 11 Pro Max")
        }
    }
}
