//
//  ToDoManager.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 9.03.2021.
//

import Foundation
class ToDoManager {
    static let shared = ToDoManager()
    
    let documentManager = DocumentManager.shared
    
    
    func fetchToDos(completion:@escaping ([ToDoItem]?) -> (Void))  {
        guard let toDoList = documentManager.readJsonFile() else {
            completion(nil)
            return }
        completion(toDoList)
    }
    

}
    
    
    

