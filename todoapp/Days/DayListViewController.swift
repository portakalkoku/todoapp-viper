//
//  DayListViewController.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 9.03.2021.
//

import UIKit


class DayListViewController: UIViewController {
    @IBOutlet weak var dayListCollectionView: UICollectionView!
    
    var presenter:ViewToPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print(presenter)
    }


}
extension DayListViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    

}

extension DayListViewController {
    
 
    
        
        
}

extension DayListViewController: PresenterToViewProtocol {
    
    func onFetchCompleted() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func reloadData() {
        
    }
    
    
}


