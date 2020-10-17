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
    @Published var isLogged = false
    @Published var showLogin = false
}
