//
//  ProfileViewController.swift
//  Expense Tracker
//
//  Created by Shunsuke Kobayashi on 8/11/22.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //reference to managed object context 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[Profile]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        print("profile view loaded")
        fetchProfile()
        
    }
    
    func fetchProfile(){
        //fetch the data from core data to display in the table view
        do{self.items = try context.fetch(Profile.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            
        }
    }
    
   
    
    @IBAction func buttonTapped(_ sender: Any) {
    
    
    
        print("tapped")
        //create alert
        let alert = UIAlertController(title: "Add Profile", message: "Add another shopping list?", preferredStyle: .alert)
        alert.addTextField()
        
        //configure button handler
        
        let submitButton = UIAlertAction(title: "Add", style: .default){
            (action) in
            let textfield = alert.textFields![0]
        
        
            let newProfile = Profile(context: self.context)
            newProfile.name = textfield.text
            newProfile.age = 20
            newProfile.gender = "Male"
            
            //save the data
            do{
            try self.context.save()
            }catch{
                
            }
            //re-fetch the data
            self.fetchProfile()
            }
        alert.addAction(submitButton)
        
        self.present(alert,animated: true,completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

