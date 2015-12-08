//
//  Movie.swift
//  TheMovieDB
//
//  Created by Jason on 1/11/15.
//

//1. Import CoreData
import UIKit
import CoreData

//2. Make a subclass of NSManagedObject
class Movie: NSManagedObject {

    struct Keys {
        static let Title = "title"
        static let PosterPath = "poster_path"
        static let ReleaseDate = "release_date"
    }

    //MARK: Properties
    
    //3, Make properties CoreData attributes
    @NSManaged var title: String
    @NSManaged var id: NSNumber
    @NSManaged var posterPath: String?
    @NSManaged var releaseDate: NSDate?
    @NSManaged var actor: Person?

    
    //MARK: Initialisers
    
    //4. Include the standard Core Data init method
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    //5. Two argument init method
    init(dictionary: [String:AnyObject], context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        title = dictionary[Keys.Title] as! String
        id = dictionary[TheMovieDB.Keys.ID] as! Int
        posterPath = dictionary[Keys.PosterPath] as? String
        releaseDate = dictionary[Keys.ReleaseDate] as? NSDate
    }
    
    var posterImage: UIImage? {
        get { return TheMovieDB.Caches.imageCache.imageWithIdentifier(posterPath) }
        set { TheMovieDB.Caches.imageCache.storeImage(newValue, withIdentifier: posterPath!) }
    }
}
