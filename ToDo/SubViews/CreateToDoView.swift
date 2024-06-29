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
    
    @Binding var showCreate: Bool
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.managedObjectContext) var objectContext
    
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
                                HStack{
                                    Image(systemName: "plus.circle")
                                }
                            }
                        )
                   
                }else {
                    PhotosPicker(selection: $viewModel.imageSelection){
                        HStack{
                            Text("Select an Image")
                            Image(systemName: "plus.circle")
                        }
                    }
                }
                TextField("Title", text: $viewModel.toDoItem.title)
                TextField("Description", text: $viewModel.toDoItem.itemDescription)
                DatePicker("Choose a date", selection: $viewModel.toDoItem.dueDate)
                Toggle(isOn: $viewModel.toDoItem.isCompleted){
                    Text("Done?")
                }
                Button(action: {
                    do{
                        try viewModel.save()
                    }catch{
                        print("couldn't save to coreData")
                    }
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
    CreateToDoView(showCreate: .constant(false),viewModel: .init(provider: .shared))
        
}
