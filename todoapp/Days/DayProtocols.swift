//
//  DayProtocols.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 9.03.2021.
//

import Foundation


import Foundation
//MARK: View -> Presenter
protocol DayViewToPresenterProtocol:class {
  func viewDidLoad()
  func selectDay()
  func fetchDays()
}
//MARK: Presenter -> View
protocol DayPresenterToViewProtocol :class{
    func fetchDays()

}
//MARK: Presenter -> Interactor
protocol  DayPresenterToInteractorProtocol :class {
    var presenter:ToDoListInteractorToPresenterProtocol? {get set}
    func fetchToDos()
    func changeToDoCompletionStatus(index:Int)
}
//MARK: Interactor->Presenter
protocol DayInteractorToPresenterProtocol:class {


}




