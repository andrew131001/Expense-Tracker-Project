//
//  ProfileExtension.swift
//  Expense Tracker
//
//  Created by Shunsuke Kobayashi on 8/11/22.
//

import UIKit
import CoreData

extension ProfileViewController {
    func fetchProfile(){
        //fetch the data from core data to display in the table view
        do{
            self.items = try context.fetch(Profile.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let profile = self.items![indexPath.row]
        
        cell.textLabel?.text = profile.name!
      //  print(profile.name!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profile = self.items![indexPath.row]
        
        //create alert
        let alert = UIAlertController(title:"Edit Item",message:"Edit Item",preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = profile.name
        //configure button handler
        let saveButton = UIAlertAction(title:"Save",style: .default){
            (action) in
            
            let textfield = alert.textFields![0]
            
            profile.name = textfield.text
            
            do{
                try self.context.save()
            }
            catch{
                
            }
            self.fetchProfile()
        }
        alert.addAction(saveButton)
        self.present(alert,animated: true,completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete"){(action,view,completionHandler) in
                
            
            let profileToRemove = self.items![indexPath.row]
            
            self.context.delete(profileToRemove)
            
            do{
                try self.context.save()
            }
            catch{
                
            }
            self.fetchProfile()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
