//
//  ChartViewController.swift
//  Expense Tracker
//
//  Created by user226918 on 8/14/22.
//

import UIKit
import Charts
import CoreData
class ChartViewController: UIViewController, ChartViewDelegate {
    
    var pieChartExpense = PieChartView()
    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        pieChartExpense.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect.init(x: 80, y: 120, width: 280, height: 25)
        label.text = "Expense Distribution"
        label.textAlignment = .center
        label.textColor = .black
        view.addSubview(label)
        pieChartExpense.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        pieChartExpense.center = view.center
        view.addSubview(pieChartExpense)
        var entries = [ChartDataEntry]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
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
       
        for x in 0..<(categoryArray.count) {
            if categoryArray[x] != "saving" && categoryArray[x] != "salary"{
                entries.append(ChartDataEntry(x: 0, y: Double(amountArray[x])) )
            }
            entries.append(ChartDataEntry(x: 0, y: Double(Double(x)) ))
        }
       
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()
        let data = PieChartData(dataSet: set)
        pieChartExpense.data = data
    }


}
