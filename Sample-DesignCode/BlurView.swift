//
//  BlueView.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/9.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIView
    let style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect.zero)
        // 确保没有其它背景颜色
        view.backgroundColor = .clear
        // 设置模糊效果
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        // 设置约束
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
