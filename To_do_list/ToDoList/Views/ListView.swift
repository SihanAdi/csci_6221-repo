//
//  ListView.swift
//  ToDoList
//
//  Created by 万思桐 on 11/28/21.
//

import SwiftUI

struct ListView: View {
    
    
    //EnvironmentObject使我们可以在任何地方共享模型数据，同时还能确保数据更新时自动保持视图更新
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack {
            //如果当前ListVIewModel中的items数组没有任何内容，那么则显示NoitemsView的页面
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }
            else{
                List{
                    //循环展示所有ListVIewModel中的items，每个item是以ListRowVIew来展示
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item) //这里的item是ItemModel类型
                            //负责当点击圆圈的时候将图标转为红色的或绿色的
                            //通过listViewModel中的updateItem实现
                            .onTapGesture {
                                //withAnimation(.linear){
                                    listViewModel.updateItem(item: item) //这里的item是ItemModel类型
                                //}
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem) //删除当前item
                    .onMove(perform: listViewModel.moveItem) //移动当前item
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo List")
        .navigationBarItems(
            leading: EditButton(),
            //点击Add后导航到AddView界面
            trailing:
                NavigationLink("Add", destination: AddView())
        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
        }
        .environmentObject(ListViewModel())
.previewInterfaceOrientation(.portrait)
    }
}
