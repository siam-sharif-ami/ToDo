//
//  ToDoItemProvider.swift
//  ToDo
//
//  Created by BS00484 on 28/6/24.
//

import Foundation
import CoreData

final class ToDoItemProvider {
    
    static let shared = ToDoItemProvider()
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    static var preview: ToDoItemProvider = {
        let provider = ToDoItemProvider(inMemory: true)
        let viewContext = provider.viewContext
        
        for index in 1..<10{
            let toDoItem = ToDoItem(context: viewContext)
            toDoItem.title = "ToDoItem \(index)"
        }
        
        do{
            try viewContext.save()
        }catch{
            print(error)
        }
        return provider
    }()
    
    /// this is just to temporarily save into memory
    var newContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    private init(inMemory: Bool = false){
        
        /// this is the name of the xcdatamodel file
        persistentContainer = NSPersistentContainer(name: "ToDo")
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
//        else {
//            let storeURL = persistentContainer.persistentStoreDescriptions.first?.url!
//            let options: [String: Any] = [
//                NSInferMappingModelAutomaticallyOption : true ,
//                NSMigratePersistentStoresAutomaticallyOption: true
//            ]
//        }

        
        /// whenever a change happens in context, it automatically get saved
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        persistentContainer.loadPersistentStores {_, error in
            if let error {
                fatalError("Unable to load store with error: \(error)")
            }
        }
    }
}
