//
//  CourseStore.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/7.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI
import Contentful
import Combine

// 设置访问令牌
let client = Client(spaceId: "8g03rd46x3qo", accessToken: "RoYGFZGDUzjmvxCLjWfCBFw2wyCyQ9_kJjwS1A6Ml_Q")

func getArray(id: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
            
        case .failure(let error):
            print(error)
        }
        
    }
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    
    // 初始化
    init() {
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subTitle"] as! String,
                    image: #imageLiteral(resourceName: "Background1"),
                    logo: #imageLiteral(resourceName: "Logo1"),
                    color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
                    show: false))
            }
        }
    }
}
