//
//  Home.swift
//  ToDoApp
//
//  Created by BS00484 on 27/6/24.
//

import SwiftUI
import CoreData

struct Home: View {
    @State private var showCreate = false
    @Environment(\.managedObjectContext) var objectContext
    
    @FetchRequest(fetchRequest: ToDoItem.all()) private var items
    var provider = ToDoItemProvider.shared
    
    var body: some View {
        
        NavigationStack{
            
            Text("To Do Items")
                .font(.title)
                .fontWeight(.bold)
            
            List{
                ForEach(items, id: \.id){ item in
                        NavigationLink(destination: {
                            DetailView(item: item)
                        }){
                            VStack{
                                Text("\(item.title)")
                                Text("\(item.itemDescription)")
                            }
                        }
                    }
            }
                .toolbar{
                    ToolbarItem{
                        
                    }
                }
                .sheet(isPresented: $showCreate, content: {
                    NavigationStack{
                        CreateToDoView(showCreate: $showCreate, viewModel: .init(provider: .shared))
                    }
                    .presentationDetents([.large])
                })
            
            HStack{
                Spacer()
                Button(action:{ showCreate.toggle()
                }, label: {
                    Image(systemName:"plus.circle.fill")
                        .resizable()
                        .frame(maxWidth: 40, maxHeight: 40)
                }).padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 40))
            }
        }
        
    }
}

#Preview {
    Home()
}
