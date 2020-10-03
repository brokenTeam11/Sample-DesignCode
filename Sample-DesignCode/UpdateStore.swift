//
//  UpdateStore.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/3.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI
import Combine

// 创建store
class UpdateStore: ObservableObject {
    // 更新存储
    @Published var updates: [Update] = updateData
}
