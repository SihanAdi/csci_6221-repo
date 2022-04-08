//
//  NoItemsView.swift
//  ToDoList
//
//  Created by 万思桐 on 11/28/21.
//

import SwiftUI

/***********
 当前没有item时候所展示的界面
 ***********/

struct NoItemsView: View {
    
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no items")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Click the Add button to add items")
                    .padding(.bottom, 30)
                //Add something按钮的构建
                NavigationLink(
                    //点击Add something转到添加界面
                    destination: AddView(),
                    label: {
                        Text("Add something 👉")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(animate ? secondaryAccentColor : Color.accentColor)
                            .cornerRadius(10)
                    }
                )
                    .padding(.horizontal, animate ? 30 : 50)
//                    .shadow(color: animate ? Color.red.opacity(0.7) : Color.accentColor.opacity(0.7),
//                            radius: animate ? 30 : 10,
//                            x: 0,
//                            y: <#T##CGFloat#>)
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    //动画函数
    func addAnimation() {
        guard !animate else { return }
        //每过1.5秒执行一次
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            //渐近渐出无限循环
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
                .navigationTitle("Title")
        }
    }
}
