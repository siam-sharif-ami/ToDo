//
//  CreateToDoView.swift
//  ToDoApp
//
//  Created by BS00484 on 27/6/24.
//

import SwiftUI
import PhotosUI
import Kingfisher
 
struct CreateToDoView: View {
    
    @State private var item = ToDoItem()
    @Binding var showCreate: Bool
    @State var viewModel: HomeViewModel
    
    var body: some View {
        VStack{
            List{
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            PhotosPicker(selection: $viewModel.imageSelection){
                                Image(systemName: "plus.circle")
                            }
                        )
                   
                }else {
                    PhotosPicker(selection: $viewModel.imageSelection){
                        Image(systemName: "plus.circle")
                    }
                }
                TextField("Title", text: $item.title)
                TextField("Description", text: $item.description)
                DatePicker("Choose a date", selection: $item.dueDate)
                Toggle(isOn: $item.isCompleted){
                    Text("Done?")
                }
                Button(action: {
                    viewModel.addToTaskList(item: item)
                    showCreate.toggle()
                } ,label: {
                    Text("Create")
                        .fontWeight(.bold)
                })
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
}

#Preview {
    CreateToDoView(showCreate: .constant(false),viewModel: HomeViewModel())
}
