
import Foundation
import CoreData

final class ToDoItem : NSManagedObject, Identifiable {
    @NSManaged var title: String
    @NSManaged var itemDescription: String
    @NSManaged var dueDate: Date
    @NSManaged var image: String?
    @NSManaged var isCompleted: Bool
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(Date.now, forKey: "dueDate")
        setPrimitiveValue(false, forKey: "isCompleted")
    }
}

extension ToDoItem {
    private static var toDoItemFetchRequest: NSFetchRequest<ToDoItem>{
        NSFetchRequest(entityName: "ToDoItem")
    }
    static func allComplete() -> NSFetchRequest<ToDoItem> {
        let request: NSFetchRequest<ToDoItem> = toDoItemFetchRequest
        request.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \ToDoItem.dueDate, ascending: true)
        ]
        return request
    }
    static func allIncomplete() -> NSFetchRequest<ToDoItem> {
            let request: NSFetchRequest<ToDoItem> = toDoItemFetchRequest
            request.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: false))
            request.sortDescriptors = [
                NSSortDescriptor(keyPath: \ToDoItem.dueDate, ascending: true)
            ]
            return request
        }
}
