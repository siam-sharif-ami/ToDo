
import Foundation

class ToDoItem : Identifiable {
    var title: String
    var description: String
    var dueDate: Date
    var image: String?
    var isCompleted: Bool
    
    init(title: String = "", description: String = "", dueDate: Date = Date.now, image: String? = nil, isCompleted: Bool = false) {
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.image = image
        self.isCompleted = isCompleted
    }
    
    static func example() -> [ToDoItem] {
        [ToDoItem(title: "Go to gym",description: "need to be fit man", dueDate: Date.now, image: "", isCompleted: false),
         ToDoItem(title: "Go study",description: "need to be wise man", dueDate: Date.now, image: "", isCompleted: true),
         ToDoItem(title: "Go code",description: "coding is fun", dueDate: Date.now, image: "", isCompleted: true)
         ]
    }
}
