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
    //@State var datePicked: Date = Date.now
    
    
    var body: some View {
        VStack{
            List{
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 150)
                        .cornerRadius(3)
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
                //                DatePicker("Choose a date", selection: $datePicked, in: Date()..., displayedComponents: .date)
                DatePicker("Choose a date", selection: $viewModel.toDoItem.dueDate, in: Date()...)
                Toggle(isOn: $viewModel.toDoItem.isCompleted){
                    Text("Done?")
                }
                Button(action: {
                    Task{
                        do{
                            //                        print("\(dateToString(date: datePicked))")
                            //                        viewModel.toDoItem.dueDate = dateToString(date: datePicked)
                            
                            let imageData = convertUIImageToData()
                            viewModel.toDoItem.image = try await viewModel.networkManager.pushToFirebaseStorage(imageData: imageData)
                            print("gimme image url -- \(viewModel.toDoItem.image)")
                            
                        }catch{
                            print("couldn't save to coreData")
                        }
                        try viewModel.save()
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
private extension CreateToDoView {
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func convertUIImageToData() -> Data {
        guard let selectedImage = viewModel.selectedImage else {
            fatalError("No image selected")
            
        }
        
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
            fatalError("Error converting image to data")
        }
        
        return imageData
    }
}

#Preview {
    CreateToDoView(showCreate: .constant(false),viewModel: .init(provider: .shared))
    
}
