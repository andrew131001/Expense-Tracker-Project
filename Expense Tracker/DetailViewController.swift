//
//  DetailViewController.swift
//  Expense Tracker
//
//  Created by Andrew Ok on 2022-07-30.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    // defince variables
    var detailImg = UIImage()
    var detailTitle = ""
    var detailTime = ""
    var detailLocation = ""
    var detailAmount = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // assign it to each object to display
        categoryImage.image = detailImg
        titleLabel.text = detailTitle
        timeLabel.text = detailTime
        locationLabel.text = detailLocation
        amountLabel.text = detailAmount
    }
}// end class
