//
//  HomeExtensions.swift
//  Expense Tracker
//
//  Created by Andrew Ok on 2022-08-09.
//

import Foundation
import UIKit

extension HomeViewController {
    
    // current date
    func getCurrentDate() {
        
        let today = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        let currentDateString = dateFormatter.string(from: today)
        self.currentDateLabel.text = currentDateString
        
    }
    
    func getCurrentBalance() {
        
        totalCurrentBalance = totalIncome - totalExpense
        
        currentBalanceLabel.text = currencyFormatter.string(from: totalCurrentBalance as NSNumber)
    }
    
    
    func getIncomeAndExpense() {
        
//        for i in 0..<expenseDetail.count {
//            if expenseDetail[i].categoryImageName == "salary" {
//                totalIncome += expenseDetail[i].amount
//            } else {
//                totalExpense += expenseDetail[i].amount
//            }
//        }
        incomeLabel.text = "+\(currencyFormatter.string(from: totalIncome as NSNumber) ?? "0.0")"
        expenseLabel.text = "-\(currencyFormatter.string(from: totalExpense as NSNumber) ?? "0.0")"
        
        
    }
    
}// end extension

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    // add cells based on the number of data array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    // assign values to each items
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.selectionStyle = .none

        
        let item = self.items!.reversed()[indexPath.row]
        

            cell.categoryImageInCell?.image = UIImage(named: item.category ?? "")!

            cell.titleInCell?.text = item.title
            cell.timeInCell?.text = item.date
            cell.amountInCell?.text = String(item.amount)
        
        

        
//        if item.category! == "salary" || item.category! == "saving" {
//            totalIncome += item.amount
//        } else {
//            totalExpense += item.amount
//        }

//        index += 1
        
        return cell
    }
    
    // fix the height of image
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    // instantiate "DetailsViewController"
    // pass data to it and go to the detail screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            let item = self.items!.reversed()[indexPath.row]
            
            detailVC.detailImg = UIImage(named: item.category ?? "")!
            detailVC.detailTitle = item.title ?? ""
            detailVC.detailTime = item.date ?? ""
            detailVC.detailLocation = item.location ?? ""
            detailVC.detailAmount = String(item.amount)
            
            self.navigationController?.pushViewController(detailVC, animated: true)
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // create sqipe action
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
                
            }
            
            // re-fresh the data
            self.fetchItems()
            
        }
        
        // return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
    

}// end extension

