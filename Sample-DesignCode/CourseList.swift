//
//  CourseList.swift
//  Sample-DesignCode
//
//  Created by 夏能啟 on 2020/10/5.
//  Copyright © 2020 夏能啟. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    // 设定环境模式
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isScrollable = false

    var body: some View {
        GeometryReader { bounds in
            ZStack {
                Color.black.opacity(Double(self.activeView.height/500))
                    .animation(.linear)
                    .edgesIgnoringSafeArea(.all)
                    

                ScrollView {
                    VStack(spacing: 30) {
                        Text("Courese")
                            .font(.largeTitle).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                            .blur(radius: self.active ? 20 : 0)
                        // `id: \.self`提供索引
                        ForEach(self.store.courses.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                CourseView(
                                    show: self.$store.courses[index].show,
                                    course: self.store.courses[index],
                                    active: self.$active,
                                    index: index,
                                    activeIndex: self.$activeIndex,
                                    activeView: self.$activeView,
                                    bounds: bounds,
                                    isScrollable: self.$isScrollable
                                )
                                    .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
                            }
                            .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
                            .frame(maxWidth: self.store.courses[index].show ? 712 : getCardWidth(bounds: bounds))
                            .zIndex(self.store.courses[index].show ? 1 : 0)
                        }
                    }
                    .frame(width: bounds.size.width)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
                // 隐藏状态栏
                .statusBar(hidden: self.active ? true : false)
                .animation(.linear)
                .disabled(self.active && !self.isScrollable ? true : false)
            }
        }
    }
}

// 适配屏幕大小ipad
func getCardWidth(bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width > 712 {
        return 712
    }
    return bounds.size.width - 60
}
// 适配屏幕大小ipad
func getCardCornerRadius(bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width < 712 && bounds.safeAreaInsets.top < 44 {
        return 0
    }
    
    return 30
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @Binding var show: Bool
    var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    var bounds: GeometryProxy
    @Binding var isScrollable: Bool

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")

                Text("About this course")
                    .font(.title).bold()

                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                Text(" controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
            }
            .animation(nil)
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color("background1"))
            // 平滑角
            .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            // 添加不透明度
            .opacity(show ? 1 : 0)

            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                        .offset(x: 2, y: -2)
                    }
                }
                Spacer()
                // WebImage是引用的第三方库
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
            // `.infinity表示安全区域`
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(Color(course.color))
            // 平滑的圆角
            .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)

            // 添加手势
            .gesture(
                show ?
                    DragGesture().onChanged { value in
//                    if value.translation.height < 300 {
//                        self.activeView = value.translation
//                    }
                        // 当if语句多了的时候不方便阅读，可以用guard来替换if语句,上面的是if语句
                        guard value.translation.height < 300 else { return }
                        guard value.translation.height > 0 else { return }
                        self.activeView = value.translation
                    }
                    // 重置
                    .onEnded { _ in
                        if self.activeView.height > 50 {
                            self.show = false
                            self.active = false
                            self.activeIndex = -1
                            self.isScrollable = false
                        }
                        self.activeView = .zero
                    }
                    : nil
            )

            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.isScrollable = true
                }
            }
            
            if isScrollable {
                CourseDetail(course: course, show: $show, active: $active, activeIndex: $activeIndex, isScrollable: $isScrollable, bounds: bounds)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: show ? getCardWidth(bounds: bounds) : 30, style: .continuous))
                    .animation(nil)
                    .transition(.identity)
            }
        }
        
        .frame(height: show ? bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom : 280)
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))
        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
            show ?
                DragGesture().onChanged { value in
                    //                    if value.translation.height < 300 {
                    //                        self.activeView = value.translation
                    //                    }
                    // 当if语句多了的时候不方便阅读，可以用guard来替换if语句,上面的是if语句
                    guard value.translation.height < 300 else { return }
                    guard value.translation.height > 50 else { return }
//                    self.activeView = value.translation
                }
                // 重置
                .onEnded { _ in
                    if self.activeView.height > 50 {
                        self.show = false
                        self.active = false
                        self.activeIndex = -1
                        self.isScrollable = false
                    }
                    self.activeView = .zero
                }
                : nil
        )
        .disabled(active && !isScrollable ? true : false)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
    Course(title: "Prototype designs in SwiftUI", subtitle: "18 Sections", image: URL(string: "https://user-images.githubusercontent.com/30774189/95600087-86e44600-0a84-11eb-84af-0a12910ac15c.png")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "Build a SwiftUI App", subtitle: "22 Sections", image: URL(string: "https://user-images.githubusercontent.com/30774189/95600715-20abf300-0a85-11eb-9cbc-d7ae685f376f.png")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "SwiftUI Advanced", subtitle: "30 Sections", image: URL(string: "https://user-images.githubusercontent.com/30774189/95600733-23a6e380-0a85-11eb-9c3c-8286401ca3b3.png")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
]
