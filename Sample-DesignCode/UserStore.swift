//
//  UserStore.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/18.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    // 存储用户的登录态
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = false
}
