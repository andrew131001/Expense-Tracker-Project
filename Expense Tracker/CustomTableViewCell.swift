//
//  CustomTableViewCell.swift
//  Expense Tracker
//
//  Created by Andrew Ok on 2022-07-30.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImageInCell: UIImageView!
    @IBOutlet weak var titleInCell: UILabel!
    @IBOutlet weak var timeInCell: UILabel!
    @IBOutlet weak var amountInCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}// end class
