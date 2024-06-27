//
//  CreateToDoView.swift
//  ToDoApp
//
//  Created by BS00484 on 27/6/24.
//

import SwiftUI
import PhotosUI

 
struct CreateToDoView: View {
    
    @State private var item = ToDoItem()
    @Binding var showCreate: Bool
    @State var selectedItems: [PhotosPickerItem] = []
    
    
    var body: some View {
        
            List{
                
                TextField("Title", text: $item.title)
                TextField("Description", text: $item.description)
                DatePicker("Choose a date", selection: $item.dueDate)
                
            }
            .navigationTitle("Create To-Do")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:{ showCreate.toggle()
                    }, label: {
                        Image(systemName: "multiply")
                    })
                            
                }
            }
    }
}

#Preview {
    CreateToDoView(showCreate: .constant(false))
}
