//
//  Movie+CoreDataProperties.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 22/05/22.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var movieName: String?

}

extension Movie : Identifiable {

}
