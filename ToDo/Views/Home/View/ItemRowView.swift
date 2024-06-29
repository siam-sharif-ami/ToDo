//
//  ItemRowView.swift
//  ToDo
//
//  Created by BS00484 on 29/6/24.
//

import SwiftUI

struct ItemRowView: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var item: ToDoItem
    
    var body: some View {
        
        VStack(alignment: .leading,
               spacing: 8) {
            
            Text("\(item.title)")
                .font(.system(size: 15,
                              design: .rounded).bold())
            
            Text("\(item.itemDescription)")
                .font(.subheadline)
            
//            Text("\(item.dueDate)")
//                .font(.subheadline)
            
        }
               .frame(maxWidth: .infinity, alignment: .leading)
               .overlay(alignment: .topTrailing) {
                   Button {
                       toggleIsCompleted()
                   } label: {
                       Image(systemName: "checkmark.circle")
                           .font(.title3)
                           .symbolVariant(.fill)
                           .foregroundColor(item.isCompleted ? .green : .gray.opacity(0.3))
                   }
                   .buttonStyle(.plain)
               }
    }
}

private extension ItemRowView {
    func toggleIsCompleted() {
        item.isCompleted.toggle()
        
        if moc.hasChanges{
            do{
                try moc.save()
            }catch{
                print("Failed to toggle Completed")
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

//#Preview {
//    ItemRowView()
//}
