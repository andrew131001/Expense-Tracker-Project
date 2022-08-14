//
//  ChartViewController.swift
//  Expense Tracker
//  Pie Chart to show the expenses
//  Created by Shovit Bastakoti on 8/14/22.
// Chart.storyboard

import UIKit
import Charts
import CoreData
class ChartViewController: UIViewController, ChartViewDelegate {
    //defining context for core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // declare and initialize the views
    var pieChartExpense = PieChartView()
    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        pieChartExpense.delegate = self //setting delegate
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //setting the label's layout
        label.frame = CGRect.init(x: 80, y: 120, width: 280, height: 25)
        label.text = "Expense Distribution"
        label.textAlignment = .center
        label.textColor = .black
        //adding label to the parent view
        view.addSubview(label)
        //setting the layout of pie chart and setting the data source
        pieChartExpense.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        pieChartExpense.center = view.center
        view.addSubview(pieChartExpense)
        var entries = [ChartDataEntry]()
        
        
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
        //declaring variables used to store data fetched fom coredata
        var categoryArray:[String] = []
        var amountArray: [Double] = []
        do {
            let result = try context.fetch(fetchRequest)
            
            // loop through the data and extract category name and amount
            
         categoryArray = result.map{$0.category ?? ""}
         amountArray = result.map{$0.amount}
        }
        catch {
            print("Cound not fetch \(error)")
        }
       //looping through the data to get numbers
        for x in 0..<(categoryArray.count) {
            if categoryArray[x] != "saving" && categoryArray[x] != "salary"{
                entries.append(ChartDataEntry(x: 0, y: Double(amountArray[x])) )
            }
            entries.append(ChartDataEntry(x: 0, y: Double(Double(x)) ))
        }
       //setting the data source and the color of pie chart
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()
        let data = PieChartData(dataSet: set)
        pieChartExpense.data = data
    }
  
    

  
}
