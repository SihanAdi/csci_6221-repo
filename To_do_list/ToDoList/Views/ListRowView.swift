//
//  ListRowView.swift
//  ToDoList
//
//  Created by 万思桐 on 11/28/21.
//

import SwiftUI

/***********
 负责每一个item的布局等
 ************/

struct ListRowView: View {
    
    let item: ItemModel
    
    //每一个item的布局，左边一个圆形check符号 右边是文字显示，显示的是ItemModel中的ItemModel.text
    var body: some View {
        HStack{
            //如果当前item的isCompleted为真，则使用绿色圆形check，为否，则使用红色check
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "First item!", isCompleted: false)
    static var item2 = ItemModel(title: "Second item!", isCompleted: true)
    
    static var previews: some View {
        Group{
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
