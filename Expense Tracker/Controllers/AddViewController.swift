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
    @IBOutlet weak var addBtn: UIButton!
    
    // declare variables
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
        popupBtn.layer.borderWidth = 0.2
        popupBtn.layer.borderColor = UIColor.lightGray.cgColor
        setPopupBtn()
        getCategoryName() // pass default value

        // date picker
        self.datePicker.addTarget(self, action: #selector(self.storeSelectedDate), for: UIControl.Event.valueChanged)
        datePicker.datePickerMode = .date // display only date, month, and year
        getCurrentDateFromDatePicker() // pass default value
        
        // add button
        addBtn.layer.cornerRadius = 5
        addBtn.titleLabel?.font = .systemFont(ofSize: 20)
        
        // gesture recognizer to dissmiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }// end viewDIdLoad
    
    
    //dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // get selected date value and pass it
    @objc func storeSelectedDate(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        selectedDate = dateFormatter.string(from: datePicker.date)
    }
    
    // set up for default date value
    func getCurrentDateFromDatePicker() {
        let today = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        selectedDate = dateFormatter.string(from: today)
    }
    
    // set up for default category name
    func getCategoryName() {
        addCategoryName = popupBtn.currentTitle ?? ""
    }
    
    // set up pop up button
    func setPopupBtn() {
        
        // get pop up button title value and assign it to addCategoryName
        let optionClosure = { (action : UIAction) in self.addCategoryName = action.title }
        
        // set items for pop up menu
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

        // pass inserted values to proper variables
        self.addTitle = titleTextField.text ?? ""
        self.addLocation = locationTextField.text ?? ""
        self.addAmount = Double(amountTextField.text ?? "0.0") ?? 0.0
        
        // create alert
        let alert = UIAlertController(title: "Confirm", message: "Successfully added!", preferredStyle: .alert)
        
        // create 'OK' button
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            // instantiate HomeViewController
            let homeVC = HomeViewController()
            
            // access to object manage context and pass values
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
                print(error)
            }
            
            // re-set all objects to default value
            self.setPopupBtn()
            self.titleTextField.text = ""
            self.locationTextField.text = ""
            self.amountTextField.text = ""
            self.datePicker.setDate(Date(), animated: false)
            
            // move to Home screen after clicking 'OK' button on dialog
            self.tabBarController?.selectedIndex = 0
        })
        
        // add button
        alert.addAction(ok)
        
        // show alert
        self.present(alert, animated: true, completion: nil)
    }// end addBtn
}// end class
