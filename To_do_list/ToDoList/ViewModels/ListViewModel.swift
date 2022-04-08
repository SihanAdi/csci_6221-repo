//
//  ListViewModel.swift
//  ToDoList
//
//  Created by 万思桐 on 11/28/21.
//

import Foundation

/*
 CRUD Function
 
 Create
 Read
 Update
 Delete
 */

class ListViewModel: ObservableObject {
    
    //数据结构items保存所有的items
    @Published var items: [ItemModel] = [] {
        didSet {
            //保存当前数据为json字符串
            saveItems()
        }
    }
    //用来保存json字符串，在下次打开文件时就会从中调取上一次保存的items
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
//        let newItems = [
//            ItemModel(title: "This is the first title!", isCompleted: false),
//            ItemModel(title: "This is the second title!", isCompleted: true),
//            ItemModel(title: "Third", isCompleted: false),
//        ]
//        items.append(contentsOf: newItems)
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            //解码itemsKey中的items数据并保存到savedItems中
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        //将当前items赋值为savedItem
        self.items = savedItems
    }
    
    //删除当前item
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    //移动当前item
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    //添加新的item到items中
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    //更新当前某一个item的isCompleted为!isCompleted
    func updateItem(item: ItemModel) {
        /*
        if let index = items.firstIndex { (existingItem) -> Bool in
            return existingItem.id == item.id
        } {
            
        } */
        
        if let index = items.firstIndex(where: { $0.id == item.id }){
            items[index] = item.undateCompletion()
        }
    }
    
    //负责在软件关掉后再次打开时也能访问到上次保存的内容
    //将当前items中的内容encode为json数据并保存到itemsKey当中
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
