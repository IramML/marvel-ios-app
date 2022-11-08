//
//  LocalComic+CoreDataProperties.swift
//  DatabaseManager
//
//  Created by Iram Martinez on 07/11/22.
//
//

import Foundation
import CoreData


extension LocalComic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalComic> {
        return NSFetchRequest<LocalComic>(entityName: "LocalComic")
    }

    @NSManaged public var desc: String?
    @NSManaged public var format: String?
    @NSManaged public var id: String?
    @NSManaged public var pageCount: String?
    @NSManaged public var title: String?
    @NSManaged public var imagePath: String?
    @NSManaged public var imageExtension: String?

}

extension LocalComic : Identifiable {

}
