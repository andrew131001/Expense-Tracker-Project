//
//  CategoryTableViewController.swift
//  Expense Tracker
//
//  Created by Andrew Ok on 2022-08-23.
//

import UIKit
import CoreData

struct Content {
    var category: String
    var title: String
    var date: String
    var amount: String
    var location: String
}

class CategoryTableViewController: UITableViewController {
    
    let categories:[String]  = ["car","card","clothes","coffee","eat-out","education","fitness","gas","gift","groceries","home","hydro","medical-expense","miscellaneous","phone","public-transport","salary","saving","travel"]
    
    // container to hold data from Core Data
    var items: [Expense] = []
    // container to hold data selected by category
    var contents: [Content] = []
    
    // define variables
    var selectedCategory: String = ""
    var selectedTitle: String = ""
    var selectedDate: String = ""
    var selectedAmount: String = ""
    var selectedLocation: String = ""
    var categoryArray: [String] = []
    var titleArray: [String] = []
    var locationArray: [String] = []
    var dateArray:[String] = []
    var amountArray:[Double] = []
    
    // reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
        getData()
    }
    
    
    //function to retrive data from CoreData
    func getData(){
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
        
        do {
            let result = try context.fetch(fetchRequest)
            
            // loop through the data and extract each item from Core Data
            categoryArray = result.map{$0.category ?? ""}
            titleArray = result.map{$0.title ?? ""}
            locationArray = result.map{$0.location ?? ""}
            amountArray = result.map{$0.amount}
            dateArray = result.map{$0.date ?? ""}
            
            // create a contents array of type Content which has each value of items of Core Data
            for i in 0...(categoryArray.count-1) {
                contents.append(Content(category: categoryArray[i], title: titleArray[i], date: dateArray[i], amount: String(format: "%.2f", amountArray[i]), location: locationArray[i]))
            }
        }
        catch {
            print("Cound not fetch \(error)")
        }
    }
    
    
    func fetchItems() {
        do {
            // fetch the data from Core Data to display in the tableview
            items = try context.fetch(Expense.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
        catch  {
            print(error)
        }
    }
    
    
    // alert for no data
    func alert() {
        // create an alert controller
        let alert = UIAlertController(title: "Alert", message: "No Data", preferredStyle: UIAlertController.Style.alert)

        // create OK button
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)

        // add button action to alert controller
        alert.addAction(ok)
        
        // display alert
        present(alert, animated: true, completion: nil)
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // display all categories
        cell.textLabel?.text = categories[indexPath.row]

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dtvc = storyboard?.instantiateViewController(withIdentifier: "CategoryDetailViewController") as! CategoryDetailViewController

        // assign the selected category name
        selectedCategory = categories[indexPath.row]

        // extract specific Contant type data from contents array by finding selected category
        let selectedItem = contents.filter {$0.category == selectedCategory}
        
        // pass data to CategoryDetailViewController
        for i in 0..<selectedItem.count {
            dtvc.titleArray.append(selectedItem[i].title)
            dtvc.dateArray.append(selectedItem[i].date)
            dtvc.amountArray.append(selectedItem[i].amount)
            dtvc.locationArray.append(selectedItem[i].location)
        }

        // if selected category has no data, display alert
        if selectedItem.isEmpty {
            alert()
        }
        
        // remove selection animation after touching
        tableView.deselectRow(at: indexPath, animated: true)
        
        // move to detail view
        navigationController?.pushViewController(dtvc, animated: true)
    }

}// end class
