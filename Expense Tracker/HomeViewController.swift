//
//  HomeViewController.swift
//  Expense Tracker
//
//  Created by Andrew Ok on 2022-07-10.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // data for the table
    var items: [Expense]?
   
    // declare variables related to lables for money calculation
    var currentBalanceString: String = ""
    var totalIncomeString: String = ""
    var totalExpenseString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a gradient layer.
        let gradientLayer = CAGradientLayer()
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = view.bounds
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        gradientLayer.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemOrange.cgColor,
        ]
        // add a sublayer
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        tableView.delegate = self
        tableView.dataSource = self

        // display current date
        getCurrentDate()

        // get items from Core Data
        fetchItems()
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    // re-fresh tableview data after adding item
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchItems()
    }
    

    func fetchItems() {
        do {
            // fetch the data from Core Data to display in the tableview
            self.items = try context.fetch(Expense.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
        catch  {
            print(error)
        }
    }
}// end class
