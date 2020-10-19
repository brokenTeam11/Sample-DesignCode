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
        // 创建一个颜色数组
        let colors = [#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)]
        var index = 0
        
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subTitle"] as! String,
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                    logo: #imageLiteral(resourceName: "Logo1"),
//                    color: colors.randomElement()!, 随机颜色
                    color: colors[index],
                    show: false))
                
                index = index + 1
            }
        }
    }
}
