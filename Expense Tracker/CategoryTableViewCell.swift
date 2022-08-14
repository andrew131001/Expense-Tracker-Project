//
//  CategoryTableViewCell.swift
//  Expense Tracker
// The custom view cell for Category Detail Table View Controller
//  Created by Shovit Bastakoti on 8/14/22.
//Category.stroyboard

import UIKit

class CategoryTableViewCell: UITableViewCell {
 

    //declare the labels
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelAmount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
