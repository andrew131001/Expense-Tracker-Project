//
//  CategoryViewController.swift
//  Expense Tracker
// Screen showing the categories of expense
// Selecting a cell (category) will show list of individual expenses on the next screen
//  Created by Shovit bastakoti on 8/14/22.
//Category.storyboard

import UIKit
import CoreData
class CategoryViewController:  UIViewController {
    let categories:[String]  = ["groceries","car","card","clothes","coffee","eat-out","education","fitness","gas","gift","home","hydro","medical-expense","miscellaneous","phone","public-transport","salary","saving","travel"]
    var categoryArray: [String] = []
    var titleArray: [String] = []
    var locationArray: [String] = []
    var dateArray:[String] = []
    var amountArray:[Double] = []
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    @IBOutlet weak var tableCategory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableCategory.delegate = self
        tableCategory.dataSource = self
        // Do any additional setup after loading the view.
    }
    

   
}
extension CategoryViewController: UITableViewDelegate,UITableViewDataSource {
    
    //instantiate second view controller and navigate to it
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let CategoryDetailTVC:CategoryDetailTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailTableViewController") as! CategoryDetailTableViewController
        
        CategoryDetailTVC.Category = categories[indexPath.row]
        // make it navigate to CategoryDetailViewController
        self.navigationController?.pushViewController(CategoryDetailTVC, animated: true)
    }
    //returns the number of rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    //function to retrive data from CoreData
    func getData(){
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
        
        do {
            let result = try context.fetch(fetchRequest)
            
            // loop through the data and extract category name
            
            categoryArray = result.map{$0.category ?? ""}
            titleArray = result.map{$0.title ?? ""}
            locationArray = result.map{$0.location ?? ""}
            amountArray = result.map{$0.amount ?? 0.0}
            dateArray = result.map{$0.date ?? ""}
            
        }
        catch {
            print("Cound not fetch \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCategory.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
       
        
        
        
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
}
