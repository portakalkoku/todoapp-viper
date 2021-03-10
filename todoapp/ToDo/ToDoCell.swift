//
//  ToDoCell.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 9.03.2021.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    
    var toDoItem:ToDoItem? = nil  {
        didSet{
            guard let toDoItem = toDoItem else {
                return
            }
            let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: toDoItem.detail)
            if toDoItem.completed {
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            }
            
            detailLabel.attributedText = attributedString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        toDoItem = nil
    }

    
}
