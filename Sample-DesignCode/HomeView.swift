//
//  HomeView.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/3.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false

    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                Spacer()

                AvatarView(showProfile: $showProfile)
                
                Button(action: { self.showUpdate.toggle() }) {
                    Image(systemName: "bell")
                    // 默认情况下是黑色
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    
                }
                .sheet(isPresented: $showUpdate) {
                    UpdateList()
                }
            }
            .padding(.horizontal, 20)
            .padding(.leading, 14)
            .padding(.top, 30)
            // HStack可以将元素对齐到顶部或底部或中间
            // HStack视图 都将水平分布
            // VStack可以对齐到左,中或右
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(sectionData) { item in
                        GeometryReader { geometry in
                            SectionView(section: item)
                                .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20), axis: (x: 0, y: 10.0, z: 0))
                        }
                        .frame(width: 275, height: 275)
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
            }

            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var section: Section

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color.white)
                Spacer()
                Image(section.logo)
            }
            Text(section.text.uppercased())
                // 最大宽度
                .frame(maxWidth: .infinity, alignment: .leading)
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        // 设置自定义阴影
            .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

// 创建数据模型，让动态展示数据
struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype designs in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card4")), color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))),
     Section(title: "Build a SwiftUI App", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Background1")), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
      Section(title: "SwiftUI Advanced", text: "18 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card6")), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))),
]


