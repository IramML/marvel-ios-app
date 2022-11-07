//
//  LocalComicImage+CoreDataProperties.swift
//  DatabaseManager
//
//  Created by Iram Martinez on 07/11/22.
//
//

import Foundation
import CoreData


extension LocalComicImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalComicImage> {
        return NSFetchRequest<LocalComicImage>(entityName: "LocalComicImage")
    }

    @NSManaged public var path: String?
    @NSManaged public var extensionImg: String?

}

extension LocalComicImage : Identifiable {

}
