
//
//  DataList.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/7.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI

struct DataList: View {
    @State var posts: [Post] = []

    var body: some View {
        List(posts) { post in
            Text(post.title)
        }
        .onAppear {
            Api().getPosts { posts in
                self.posts = posts
            }
        }
    }

    struct DataList_Previews: PreviewProvider {
        static var previews: some View {
            DataList()
        }
    }
}
