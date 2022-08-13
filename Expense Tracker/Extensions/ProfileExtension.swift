//
//  ProfileExtension.swift
//  Expense Tracker
//
//  Created by Shunsuke Kobayashi on 8/11/22.
//

import Foundation
import UIKit
import CoreData

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ProfileCell
        
        let profile = self.items![indexPath.row]
        
        cell.nameLabel?.text = profile.name!
      //  print(profile.name!)
        return cell
    }
}
