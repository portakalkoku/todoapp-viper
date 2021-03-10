//
//  ToDosRouter.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 8.03.2021.
//

import UIKit
class ToDoListRouter:PresenterToRouterProtocol{
    static func createModule() -> ToDoListViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "toDoListViewController") as! ToDoListViewController
        
        
        
        let presenter:ViewToPresenterProtocol & InteractorToPresenterProtocol = ToDoListPresenter()
        let interactor: PresenterToInteractorProtocol = ToDoListInteractor()
        let router: PresenterToRouterProtocol = ToDoListRouter()
        
        
        //Connecting layers
        
        view.presenter = presenter
        presenter.view = view

        
       
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        
        return view
    }
    
    
}
