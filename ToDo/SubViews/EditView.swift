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
    //@State var dateShown: Date = Date.now
    
    var body: some View {
        VStack{
            List{

                TextField("Title", text: $item.title )
                TextField("Description", text: $item.itemDescription)
                
                DatePicker("Choose a date", selection: $item.dueDate, in: Date()...)
                
                Toggle(isOn: $item.isCompleted ){
                    Text("Complete?")
                }
                Button(action: {
//                    item.dueDate = dateToString(date: dateShown)
                    save()
                    showEdit.toggle()
                } ,label: {
                    Text("Save")
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
//            .onAppear(){
//                self.dateShown = stringToDate(dateString: item.dueDate ?? "19/04/2024")
//            }
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
    
    func stringToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateString) ?? Date.distantFuture
        
    }
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Create a mock managed object context for preview purposes
//        let context = ToDoItemProvider.shared.viewContext
//
//        // Create a sample ToDoItem for the preview
//        let newItem = ToDoItem(context: context)
//        newItem.title = "Sample Title"
//        newItem.itemDescription = "Sample Description"
//        newItem.dueDate = Date.now
//        newItem.isCompleted = false
//
//        return EditView(showEdit: .constant(true), item: newItem, dateShown: Date.now)
//            .environment(\.managedObjectContext, context)
//    }
//}

//#Preview {
//    EditView(item: )
//}
