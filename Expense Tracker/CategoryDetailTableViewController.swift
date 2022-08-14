//
//  CategoryDetailTableViewController.swift
//  Expense Tracker
// Screen showing the individual records in table form
//  Created by Shovit Bastakoti on 8/14/22.
//Category.storyboard

import UIKit
import CoreData
class CategoryDetailTableViewController: UITableViewController {
    //declare views and variables
    @IBOutlet weak var tableview: UITableView!
    var titleArray: [String] = []
    var categoryArray: [String] = []
    var locationArray: [String] = []
    var dateArray:[String] = []
    var amountArray:[Double] = []
    var Category:String?
    
    
    //define context for core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //function to retrieve data from Coredata
    func getData(){
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
        
        do {
            let result = try context.fetch(fetchRequest)
            
            // loop through the data and extract category name and
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

   //setting the seperator between rows
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
      

    }


 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        getData()
        return titleArray.count
    }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let rcell = tableview.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
       let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
       rcell.layoutMargins = UIEdgeInsets.zero
       do {
           let result = try context.fetch(fetchRequest)
           
           // loop through the data and extract category name
           
           categoryArray = result.map{$0.category ?? "Default"}
           titleArray = result.map{$0.title ?? "Default"}
           locationArray = result.map{$0.location ?? "Default"}
           amountArray = result.map{$0.amount ?? 0.0}
           dateArray = result.map{$0.date ?? "Default"}
           
       }
       catch {
           print("Cound not fetch \(error)")
       }
       //setting the label based on the category selected in previous screen
       
       for i in 0..<(titleArray.count){
           if Category == categoryArray[indexPath.row] {
               //setting the table cell labels from coredata
               rcell.labelTitle?.text = titleArray[indexPath.row]
               rcell.labelLocation?.text = locationArray[indexPath.row]
               rcell.labelDate?.text = dateArray[indexPath.row]
               rcell.labelAmount?.text = String(format: "%.2f", amountArray[indexPath.row])
           }
           
       }
       
    
        
      
        return rcell
    }

}
