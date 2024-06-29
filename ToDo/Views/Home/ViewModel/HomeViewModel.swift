//
//  HomeViewModel.swift
//  ToDoApp
//
//  Created by BS00484 on 27/6/24.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI
import FirebaseStorage
import CoreData


class HomeViewModel: ObservableObject {
    
    @Published var toDoItem: ToDoItem
    private let context: NSManagedObjectContext
    var provider = ToDoItemProvider.shared
    
    var selectedImage: UIImage?
    var imageSelection: PhotosPickerItem? = nil {
        didSet{
            setImage(from: imageSelection)
            print("setting image to selectedImage")
        }
    }
    
    init(provider: ToDoItemProvider, temptoDoItem: ToDoItem? = nil){
        self.context = provider.newContext
        self.toDoItem = ToDoItem(context: self.context)
    }
    ////
    ///
    ///
    ///
    func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    
    func setImage(from selection: PhotosPickerItem?){
        guard let selection else { print("could'nt get selectedImage"); return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self){
                if let uiImage = UIImage(data: data){
                    selectedImage = uiImage
                }else {
                    print("error selecting image")
                }
            }
        }
        
        print("Image set successfully")
    }
    
    func pushToFirebaseStorage(){
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//        
//        let imagesRef = storageRef.child("images")
//        let storagePath = "\gs://todo-b06b4.appspot.com/images/space.jpg)"
//        spaceRef = storage.reference(forURL: storagePath)
    }
    
}
