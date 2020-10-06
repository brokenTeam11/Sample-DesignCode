//
//  DataStore.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/7.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    // 初始化
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
