//
//  HomeExtensions.swift
//  Expense Tracker
//
//  Created by Andrew Ok on 2022-08-09.
//

import Foundation
import UIKit
import CoreData

extension HomeViewController {
    // get current date
    func getCurrentDate() {
        
        let today = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        let currentDateString = dateFormatter.string(from: today)
        self.currentDateLabel.text = currentDateString
    }// end function
}// end extension

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // add cells based on the number of data array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }// end function
    
    
    // display each rows on tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell

        // no style applies when user touch the cell
        cell.selectionStyle = .none
        
        // get item from array and set the objects
        let item = self.items!.reversed()[indexPath.row]
        
        cell.categoryImageInCell.image = UIImage(named: item.category ?? "")!
        cell.titleInCell.text = item.title
        cell.timeInCell.text = item.date
        cell.amountInCell.text = String(format: "%.2f", item.amount)
        
        // define variables regarding income, expense, and balance
        var categoryArray: [String] = []
        var amountArray: [Double] = []
        var totalIncome: Double = 0.0
        var totalExpense: Double = 0.0
        var totalCurrentBalance: Double = 0.0
        
        // fetch Core Data
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
        
        do {
            let result = try context.fetch(fetchRequest)
            
            // loop through the data and extract category name and amount
            categoryArray = result.map{$0.category ?? ""}
            amountArray = result.map{$0.amount}
        }
        catch {
            print("Cound not fetch \(error)")
        }
        
        // pass specific amount based on category name
        for i in 0...(categoryArray.count-1) {
            if categoryArray[i] == "saving" || categoryArray[i] == "salary" {
                totalIncome += amountArray[i]
            } else {
                totalExpense += amountArray[i]
            }
        }
        
        // display income, expense, and balance
        incomeLabel.text = "+\(String(format: "%.2f", totalIncome))"
        expenseLabel.text = "-\(String(format: "%.2f", totalExpense))"
        totalCurrentBalance = totalIncome - totalExpense
        currentBalanceLabel.text = String(format: "%.2f", totalCurrentBalance)
        
        return cell
    }// end function
    
    
    // fix the height of image
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }// end function
    
    
    // instantiate "DetailsViewController"
    // pass data to it and go to the detail screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? HomeDetailViewController {
            
            // fet and assign values to proper variables in detail view controller
            let item = self.items!.reversed()[indexPath.row]
            
            detailVC.detailImg = UIImage(named: item.category ?? "")!
            detailVC.detailTitle = item.title ?? ""
            detailVC.detailTime = item.date ?? ""
            detailVC.detailLocation = item.location ?? ""
            detailVC.detailAmount = String(format: "%.2f", item.amount)
            
            // move to detail view controller
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }// end function
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            
            // which item to remove
            let itemToRemove = self.items!.reversed()[indexPath.row]
            
            // remove the item
            self.context.delete(itemToRemove)
            
            // save the data
            do {
                try self.context.save()
            }
            catch {
                print(error)
            }
            // re-fresh the data
            self.fetchItems()
        }
        // return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
}// end extension

