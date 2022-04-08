//
//  AddView.swift
//  ToDoList
//
//  Created by 万思桐 on 11/28/21.
//

import SwiftUI

/********
 添加文本界面
 *********/

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                
                //添加按钮 action获取saveButtonPressed函数判断文本是否合规
                Button(action: saveButtonPressed, label: {
                    Text("Save" .uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(5)
        }
        .navigationTitle("Add an Item")
        //展示Alert，即文本小于3时，弹出提示
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() { //添加页面按钮按下
        if textIsAppropriate() == true { //如果当前文本合规，即大于3个字符
            //通过ListViewModel的addItem功能添加该文本
            listViewModel.addItem(title: textFieldText)
            
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    //check the character
    func textIsAppropriate() -> Bool { //判断文本是否合规 （大于3个字符）
        if textFieldText.count < 3
        {
            //alert文本
            alertTitle = "Your new todo item must be at least 3 characters long 🧐"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert { //获取Alert文本alertTitle
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
