//
//  Profile+CoreDataProperties.swift
//  Expense Tracker
//
//  Created by Shunsuke Kobayashi on 8/11/22.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: String?
    @NSManaged public var gender: String?
    @NSManaged public var age: Int64

}

extension Profile : Identifiable {

}
