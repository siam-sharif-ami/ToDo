//
//  HomeViewModel.swift
//  ToDoApp
//
//  Created by BS00484 on 27/6/24.
//

import Foundation

@Observable
class HomeViewModel {
    var toDoItem: [ToDoItem]? = ToDoItem.example()
    
    
    func fetchTaskList() -> [ToDoItem] {
        return toDoItem ?? ToDoItem.example()
    }
    
    func addToTaskList(item: ToDoItem){
        toDoItem?.append(item)
    }
    
}
