//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Bhagat Singh on 4/4/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
