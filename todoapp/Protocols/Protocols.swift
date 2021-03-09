//
//  ToDoListProtocol.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 9.03.2021.
//

import Foundation
//MARK: View -> Presenter
protocol ViewToPresenterProtocol:class {
    var view:PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func viewWillAppear()
    func taskTapped(indexPath:IndexPath)
    func dayTapped()
    func toDosCount()->Int
    func toDo(indexPath:IndexPath)->ToDoItem?
}
//MARK: Presenter -> View
protocol PresenterToViewProtocol :class{
    func onFetchCompleted()
    func showLoading()
    func hideLoading()
    func reloadData()

}
//MARK: Presenter -> Interactor
protocol  PresenterToInteractorProtocol :class {
    var presenter:ToDoListInteractorToPresenterProtocol? {get set}
    func fetchToDos()
    func changeToDoCompletionStatus(index:Int)
}
//MARK: Interactor->Presenter
protocol InteractorToPresenterProtocol:class {
    func fetchToDosSuccess(toDos:[ToDoItem])
    func fetchToDosFailure(error:String)
    func completeStatusChanged(toDos:[ToDoItem])
    
}
//MARK:Presenter->Router
protocol PresenterToRouterProtocol :class{
    static func createModule() -> ToDoListViewController
}




