//
//  EditView.swift
//  ToDo
//
//  Created by BS00484 on 29/6/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct EditView: View {
    
    @Binding var showEdit: Bool
    @Environment(\.managedObjectContext) var moc
    @State var item: ToDoItem
    
    var body: some View {
        VStack{
            List{

                TextField("Title", text: $item.title)
                TextField("Description", text: $item.itemDescription)
                DatePicker("Choose a date", selection: $item.dueDate)
                Toggle(isOn: $item.isCompleted){
                    Text("Done?")
                }
                Button(action: {
                    save()
                    showEdit.toggle()
                } ,label: {
                    Text("Done")
                        .fontWeight(.bold)
                })
            }
            
            .navigationTitle("Update")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:{ showEdit.toggle()
                    }, label: {
                        Image(systemName: "multiply")
                    })
                    
                }
            }
        }
    }
}

private extension EditView{
    func save(){
        if moc.hasChanges {
            do{
               try moc.save()
            }catch{
                print("error editing and saving to core data \(error.localizedDescription)")
            }
        }
    }
}
//
//#Preview {
//    EditView()
//}
