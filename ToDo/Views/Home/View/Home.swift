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
            
            List{
                ForEach(viewModel.toDoItem, id: \.id){ item in
                        NavigationLink(destination: {
                            DetailView()
                        }){
                            HStack{
                                Text("\(item.title)")
                            }
                        }
                    }
            }
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
                        CreateToDoView(showCreate: $showCreate, viewModel: viewModel)
                    }
                    .presentationDetents([.large])
                })
        }
        
    }
}

#Preview {
    Home(viewModel: HomeViewModel())
}
