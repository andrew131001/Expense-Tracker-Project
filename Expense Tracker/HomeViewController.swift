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
    
    
    

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Expense]?
   
    let currencyFormatter = NumberFormatter()
    
    var totalCurrentBalance: Double = 0.0
    var currentBalanceString: String = ""
    
    var totalIncome: Double = 0.0
    var totalIncomeString: String = ""
    
    var totalExpense: Double = 0.0
    var totalExpenseString: String = ""
    
    var category: [String] = []
    var money: [Double] = []
    var index = 0
    var homeCellImage = UIImage()

    

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
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        tableView.delegate = self
        tableView.dataSource = self

        
        
        getCurrentDate()
        getIncomeAndExpense()
        getCurrentBalance()
        
        fetchItems()
        
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchItems()
    }
    
    func fetchItems() {
        do {
            self.items = try context.fetch(Expense.fetchRequest())
            
            DispatchQueue.main.async {

                
                self.tableView?.reloadData()
                
            }
            
        } catch  {
            
        }
    }
    
    
    
    
}// end class






