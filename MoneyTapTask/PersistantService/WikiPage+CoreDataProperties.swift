//
//  WikiPage+CoreDataProperties.swift
//  MoneyTapTask
//
//  Created by Anoop on 13/10/18.
//  Copyright © 2018 Anoop. All rights reserved.
//
//

import Foundation
import CoreData


extension WikiPage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WikiPage> {
        return NSFetchRequest<WikiPage>(entityName: "WikiPage")
    }

    @NSManaged public var pageTitle: String?
    @NSManaged public var pageID: String?
    @NSManaged public var pageDescription: String?
    @NSManaged public var pageImageUrl: String?

}
