//
//  Modifiers.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/5.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI

// 封装阴影修饰符
struct ShadowModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

// 封装字体修饰符
struct FontModifer: ViewModifier {
    // 添加自定义的字体
    var style: Font.TextStyle = .body
    
    func body(content: Content) -> some View {
        content
        .font(.system(style, design: .rounded))
    }
}


// 自定义字体
struct CustomFontModifier: ViewModifier {
    // 为字体设置自定义大小
    var size: CGFloat  = 28
    
    func body(content: Content) -> some View {
        content.font(.custom("WorkSans-Bold", size: size))
    }
}
