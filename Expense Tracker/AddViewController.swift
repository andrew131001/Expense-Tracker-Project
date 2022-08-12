//
//  AddViewController.swift
//  Expense Tracker
//
//  Created by Andrew Ok on 2022-08-09.
//

import UIKit


class AddViewController: UIViewController {

    @IBOutlet weak var popupBtn: UIButton!
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let date = Date()
    let dateFormatter = DateFormatter()
    var selectedDate: String?

   
    

    var addCategoryName: String = ""
    var addTitle: String = ""
    var addLocation: String = ""
    var addAmount: Double = 0.0
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // popup button
        popupBtn.layer.cornerRadius = 5
        setPopupBtn()
        getCategoryName()
        

        // datepicker
        self.datePicker.addTarget(self, action: #selector(self.storeSelectedDate), for: UIControl.Event.valueChanged)
        datePicker.datePickerMode = .date
        getCurrentDateFromDatePicker()

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
       
        
        
        
    }// end viewDIdLoad
    
    //dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
     
    @objc func storeSelectedDate(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        selectedDate = dateFormatter.string(from: datePicker.date)
    }
    
    
    func getCurrentDateFromDatePicker() {
        let today = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        selectedDate = dateFormatter.string(from: today)
        
    }
    
    func getCategoryName() {
        addCategoryName = popupBtn.currentTitle ?? ""
    }
    
    
    
    func setPopupBtn() {
        
        let optionClosure = { (action : UIAction) in
            
            self.addCategoryName = action.title
            print("\(self.addCategoryName)")
            print("print for \(action.title)"
            
            )}
        
        
        popupBtn.menu = UIMenu(children: [
            UIAction(title: "groceries", handler: optionClosure),
            UIAction(title: "car", handler: optionClosure),
            UIAction(title: "card", handler: optionClosure),
            UIAction(title: "clothes", handler: optionClosure),
            UIAction(title: "coffee", handler: optionClosure),
            UIAction(title: "eat-out", handler: optionClosure),
            UIAction(title: "education", handler: optionClosure),
            UIAction(title: "fitness", handler: optionClosure),
            UIAction(title: "gas", handler: optionClosure),
            UIAction(title: "gift", handler: optionClosure),
            UIAction(title: "home", handler: optionClosure),
            UIAction(title: "hydro", handler: optionClosure),
            UIAction(title: "medical-expense", handler: optionClosure),
            UIAction(title: "miscellaneous", handler: optionClosure),
            UIAction(title: "phone", handler: optionClosure),
            UIAction(title: "public-transport", handler: optionClosure),
            UIAction(title: "salary", handler: optionClosure),
            UIAction(title: "saving", handler: optionClosure),
            UIAction(title: "travel", handler: optionClosure)
        ])
        
        popupBtn.showsMenuAsPrimaryAction = true
        popupBtn.changesSelectionAsPrimaryAction = true
        
    }


    
    @IBAction func addBtn(_ sender: Any) {

        
        self.addTitle = titleTextField.text ?? ""
        self.addLocation = locationTextField.text ?? ""
        self.addAmount = Double(amountTextField.text ?? "0.0") ?? 0.0

        let alert = UIAlertController(title: "Confirm", message: "Successfully added!", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            
            let homeVC = HomeViewController()
            
            let newItem = Expense(context: homeVC.context)
            newItem.category = self.addCategoryName
            newItem.title = self.addTitle
            newItem.date = self.selectedDate
            newItem.location = self.addLocation
            newItem.amount = self.addAmount
            
            // save data
            do {
                try homeVC.context.save()
                
            }
            catch {
                
            }

            
            // re-fetch the data
            homeVC.fetchItems()
            
            self.setPopupBtn()
            self.titleTextField.text = ""
            self.locationTextField.text = ""
            self.amountTextField.text = ""
            self.datePicker.setDate(Date(), animated: false)
            
            
            self.tabBarController?.selectedIndex = 0
            
            
        })
        
        
        
        // add button
        alert.addAction(ok)
        
        // show alert
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
        
        
    }// end addBtn

    
    

}// end class
