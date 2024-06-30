//
//  ItemRowView.swift
//  ToDo
//
//  Created by BS00484 on 29/6/24.
//

import SwiftUI
import Kingfisher

struct ItemRowView: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var item: ToDoItem
    
    var body: some View {
        
        VStack{
            if let imageURL = item.image {
                KFImage.url(URL(string: imageURL))
                    .placeholder {
                        // Placeholder while loading
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            HStack {
                Button {
                    toggleIsCompleted()
                } label: {
                    Image(systemName: item.isCompleted ? "checkmark.square": "square")
                }
                .buttonStyle(.plain)
                
                VStack(alignment: .leading){
                    Text("\(item.title)")
                    
                    Text("\(item.itemDescription)")
                        .font(.subheadline)
                }
                .frame(width: 200)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                
                Text("\(item.dueDate)")
                    .font(.subheadline)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
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
}

#Preview {
    ItemRowView(item: ToDoItem())
}
