//
//  Expense+CoreDataProperties.swift
//  Expense Tracker
//
//  Created by Andrew Ok on 2022-08-09.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var category: String?
    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var location: String?
    @NSManaged public var amount: Double

}

extension Expense : Identifiable {

}
