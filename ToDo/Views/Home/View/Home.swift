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
    @State private var showEdit = false
    
    @State private var selectedItem: ToDoItem?
    @Environment(\.managedObjectContext) var objectContext
    @ObservedObject var viewModel: HomeViewModel
    var provider = ToDoItemProvider.shared
    @FetchRequest(fetchRequest: ToDoItem.allIncomplete()) var items
    @FetchRequest(fetchRequest: ToDoItem.allComplete()) var doneItems
    
    var body: some View {
        
        NavigationStack{
            List{
                Section(header: Text("To Do Items")) {
                    ForEach(items, id: \.id){ item in
                        
                        ItemRowView(item: item)
                            .swipeActions {
                                Button(role: .destructive) {
                                    // Add your delete action here
                                    do{
                                        try delete(item)
                                    }catch{
                                        print(error.localizedDescription)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .swipeActions{
                                Button(action: {
                                    selectedItem = item
                                    showEdit.toggle()
                                }, label: {
                                    Label("Edit", systemImage: "pencil.circle")
                                        .tint(Color.orange)
                                })
                            }
                    }
                }
                Section(header: Text("Completed")) {
                    ForEach(doneItems, id: \.id){ item in
                        ItemRowView(item: item)
                            .swipeActions {
                                Button(role: .destructive) {
                                    // Add your delete action here
                                    do{
                                        try delete(item)
                                    }catch{
                                        print(error.localizedDescription)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .swipeActions{
                                Button(action: {
                                    selectedItem = item
                                    showEdit.toggle()
                                    
                                }, label: {
                                    Label("Edit", systemImage: "pencil.circle")
                                        .tint(Color.orange)
                                })
                            }
                    }
                }
            }
            .sheet(isPresented: $showCreate, content: {
                NavigationStack{
                    CreateToDoView(showCreate: $showCreate, viewModel: .init(provider: .shared))
                }
                .presentationDetents([.large])
            })
            .sheet(isPresented: $showEdit, content: {
                NavigationStack{
                    if let item = selectedItem {
                        EditView(showEdit: $showEdit, item: item)
                    }else {
                        Text("item not selected")
                    }
                }
            })
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { showCreate.toggle() }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .padding()
                        }
                    }
                }
            )
        }
        
    }
}

private extension Home {
    func delete(_ item: ToDoItem) throws{
        let context = provider.viewContext
        let existingItem = try context.existingObject(with: item.objectID)
        context.delete(existingItem)
        
        if context.hasChanges{
            try context.save()
        }
    }
    
    
}

#Preview {
    Home(viewModel: .init(provider: .shared))
}
