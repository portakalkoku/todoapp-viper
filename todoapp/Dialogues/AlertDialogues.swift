//
//  AlertDialogues.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 10.03.2021.
//

import Foundation
import UIKit
class AlertDialogues {
    
    static let shared = AlertDialogues()
    
    func showInputDialog(view:UIViewController,completion: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: "What do you want to do?", message: "Enter a task", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = ""
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?[0] else {
                return
            }
            
            completion(textField.text)
        }))
            
        view.present(alert, animated: true, completion: nil)
    }
    
    func showAlertDialog(view:UIViewController,message:String) {
        let alertDialog = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alertDialog.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alertDialog, animated: true, completion: nil)
    }

    
}
