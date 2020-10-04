//
//  RingView.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/4.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI

struct RingView: View {
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var width: CGFloat = 88
    var height: CGFloat = 88
    // 设置百分比，给个默认值
    var percent: CGFloat = 44
    
    
    
    
    var body: some View {
        // 按比例适配圆形文字大小
        let multiplier = width / 44
        // 进度
        // `0.2代表80%, 0.1代表90%, 1代表100%`
        let progress = 1 - percent / 100  // 翻译过来就是 =>  1 - (88 / 100) , 1 - 0.88 = 0.12 . 它的值0.12是percent的进度。这是假数据,
        
        return ZStack {
            // 非活动循环
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: height)
            
            // 活动循环
            Circle()
                // 添加进度条 `0.2代表80%, 0.1代表90%`
                .trim(from: progress, to: 1)
                .stroke(
                    // 渐变颜色`LinearGradient`线性渐变
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
                )
                // 旋转了90度
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            // 设置大小宽高
            .frame(width: width, height: height)
            // 设置自定义阴影
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            // Text("\(percent)%") => 输出的值是44.000000% . 要把小数转换成整数用Int包裹一下`Text("\(Int(percent))%")`
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
