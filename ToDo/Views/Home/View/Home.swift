//
//  Home.swift
//  ToDoApp
//
//  Created by BS00484 on 27/6/24.
//

import SwiftUI

struct Home: View {
    @State private var showCreate = false
    @State var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack{
            
//            if let items = viewModel.toDoItem {
//                ScrollView{
//                    ForEach(items, id: \.self){item in
//                        List{
//                            Text("\(item.title)")
//                            Text("\(item.description)")
//                            Text("\(item.dueDate)")
//                            Text("\(item.isCompleted)")
//                        }
//                    }
//                }
//            }
            
            Text("Task List")
                .toolbar{
                    ToolbarItem{
                        Button(action:{ showCreate.toggle()
                        }, label: {
                            Label("Add Item", systemImage: "plus")
                        })
                    }
                }
                .sheet(isPresented: $showCreate, content: {
                    NavigationStack{
                        CreateToDoView(showCreate: $showCreate)
                    }
                    .presentationDetents([.large])
                })
        }
        
    }
}

#Preview {
    Home()
}
