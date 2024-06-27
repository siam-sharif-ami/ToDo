//
//  HomeViewModel.swift
//  ToDoApp
//
//  Created by BS00484 on 27/6/24.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI


@Observable
class HomeViewModel {
    var toDoItem: [ToDoItem] = []
    var selectedImage: UIImage?
    var imageSelection: PhotosPickerItem? = nil {
        didSet{
            setImage(from: imageSelection)
        }
    }
    
    func fetchTaskList() -> [ToDoItem] {
        return toDoItem
    }
    
    func addToTaskList(item: ToDoItem){
        toDoItem.append(item)
        print(toDoItem.count)
        print("item added ")
    }
    
    func setImage(from selection: PhotosPickerItem?){
        guard let selection else { return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self){
                if let uiImage = UIImage(data: data){
                    selectedImage = uiImage
                }
            }
        }
    }
    
}
