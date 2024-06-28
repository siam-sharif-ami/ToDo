//
//  DetailView.swift
//  ToDo
//
//  Created by BS00484 on 27/6/24.
//

import SwiftUI

struct DetailView: View {
    
    let item: ToDoItem
    
    var body: some View {
        
        Text("\(item.title)")
        Text("\(item.itemDescription)")
        Text("\(item.dueDate)")
        Text("\(item.isCompleted)")
    }
}

//#Preview {
//    DetailView(item: )
//}
