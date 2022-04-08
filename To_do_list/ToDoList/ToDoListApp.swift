//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by 万思桐 on 11/28/21.
//

/*
 MVVM Architecture
 
 Model
 View
 ViewModel
 
 */

import SwiftUI

@main
struct ToDoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
