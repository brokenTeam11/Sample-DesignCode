//
//  Data.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/7.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI

struct Post: Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
}

class Api {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        // 这里设置guard的意图是为了解决下面URLSession里面的url安全类型报错问题
        guard let url = URL(string: "http://jsonplaceholder.typicode.com/posts") else { return }
        // 下划线表示暂时不会用到
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            // 用"!"强制解包的时候要慎重，做好容错处理有备无患。
            guard let data = data else {return}
            let posts = try! JSONDecoder().decode([Post].self, from: data )
            
            // 多线程
            DispatchQueue.main.async {
                completion(posts)
            }
            
        }
    .resume()
    }
}
