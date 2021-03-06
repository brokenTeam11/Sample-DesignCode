//
//  UpdateList.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/3.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    
    func addUpdate() {
        store.updates.append(Update(image: "Card1", title: "New Item", text: "text", date: "Jan 1"))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.updates) { update in
                    NavigationLink(destination: UpdateDetail(update: update)) {
                        HStack {
                            Image(update.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text(update.title)
                                    .font(.system(size: 20, weight: .bold))
                                Text(update.text)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                Text(update.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete { index in
                    self.store.updates.remove(at: index.first!)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(leading: Button(action: addUpdate) {
            Text("Add Update")
            }, trailing: EditButton())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

// 创建数据模型
struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

// 设置样本数据
let updateData = [
    Update(image: "Card1", title: "SwiftUI Advanced", text: "SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced", date: "Jan 1"),
    Update(image: "Card2", title: "WebFlow", text: "WebFlow SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced", date: "Jan 1"),
    Update(image: "Card3", title: "ProtoPie", text: "ProtoPie SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced", date: "Jan 1"),
    Update(image: "Card4", title: "SwiftUI", text: "SwiftUI ProtoPie SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced", date: "Jan 1"),
    Update(image: "Card5", title: "Framer", text: "Framer ProtoPie SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced SwiftUI Advanced", date: "Jan 1"),
]
