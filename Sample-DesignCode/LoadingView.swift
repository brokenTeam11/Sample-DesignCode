//
//  LoadingView.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/13.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(filename: "cat")
                .frame(width: 200, height: 200)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
