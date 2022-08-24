//
//  CategoryDetailViewController.swift
//  Expense Tracker
//
//  Created by Andrew Ok on 2022-08-23.
//

import UIKit
import CoreData

class CategoryDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var categoryArray: [String] = []
    var titleArray: [String] = []
    var dateArray:[String] = []
    var amountArray:[String] = []
    var locationArray: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        // for tableview
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    
    // fix the height of image
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // show number of rows based on the length of titleArray
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    // display data chosen by user
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let rcell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryTableViewCell
        
        rcell.dtvcTitleLabel?.text = titleArray[indexPath.row]
        rcell.dtvcLocationLabel?.text = locationArray[indexPath.row]
        rcell.dtvcDateLabel?.text = dateArray[indexPath.row]
        rcell.dtvcAmountLabel?.text = amountArray[indexPath.row]
        
        return rcell
    }
}// ens class
