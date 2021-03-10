//
//  Managers.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 8.03.2021.
//

import Foundation

class DayManager {
    
    static let shared = DayManager()
  
    let dayList:[Day] = [Day(name: "Monday", id: 1,selected:false),Day(name: "Tuesday", id: 2,selected:false),Day(name: "Wednesday", id: 3,selected:false),Day(name: "Thursday", id: 4, selected: false),Day(name: "Friday", id: 5, selected: false),Day(name: "Saturday", id: 6, selected: false),Day(name: "Sunday", id: 7, selected: false)]
    
    
    
}
