//
//  ItemTabView.swift
//  ToDo
//
//  Created by BS00484 on 27/6/24.
//

import SwiftUI
import Kingfisher

struct ItemTabView: View {
    
    var item: ToDoItem
    
    var body: some View {
        
        HStack{
            if let image = item.image {
                KFImage(URL(string: image))
                    .resizable()
                    .frame(width: 35, height: 35)
                
            }else {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
            }
            
            VStack{
                Text("\(item.title)")
                Text("\(item.itemDescription)")
                Text("\(formattedCurrentDate(date: item.dueDate))")
            }
        
        }
        .padding()
    }
}

func formattedCurrentDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM--dd"
    return formatter.string(from: date)
}

#Preview {
    ItemTabView(item: ToDoItem())
}
