//
//  CategoryTableViewCell.swift
//  Expense Tracker
//
//  Created by Andrew Ok on 2022-08-23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dtvcTitleLabel: UILabel!
    @IBOutlet weak var dtvcDateLabel: UILabel!
    @IBOutlet weak var dtvcAmountLabel: UILabel!
    @IBOutlet weak var dtvcLocationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
