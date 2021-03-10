//
//  DayCellCollectionViewCell.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 9.03.2021.
//

import UIKit

class DayCell: UICollectionViewCell {

    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var day:Day? = nil {
        didSet {
            guard let day = day else {
                return
            }
            
            nameLabel.text = day.name
            if(day.selected) {
                dayView.backgroundColor = UIColor.systemOrange
            }
            

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dayView.layer.cornerRadius = 10
       
    }
    
    override func prepareForReuse() {
        day = nil
        dayView.backgroundColor = UIColor.systemGreen
        
    }

}
