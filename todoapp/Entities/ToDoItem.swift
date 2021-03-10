//
//  ToDoItem.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 8.03.2021.
//

import Foundation
struct ToDoItem : Codable{
    var detail:String
    var completed:Bool
    let uuid:UUID
    var belongTo:Int
    init(detail: String, completed: Bool, uuid: UUID,belongTo:Int) {
        self.detail  = detail
        self.completed = completed
        self.uuid = uuid
        if(belongTo > 7) {
            self.belongTo = 7
        }else if(belongTo<1) {
            self.belongTo = 1
        }else {
            self.belongTo = belongTo
        }
    }
    
}
