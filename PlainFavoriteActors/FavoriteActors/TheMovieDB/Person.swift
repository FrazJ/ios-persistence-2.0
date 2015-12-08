//
//  Person.swift
//  TheMovieDB
//
//  Created by Jason on 1/11/15.
//

import UIKit
import CoreData

class Person : NSManagedObject {

    struct Keys {
        static let Name = "name"
        static let ProfilePath = "profile_path"
        static let Movies = "movies"
        static let ID = "id"
    }

    
    //MARK: Properties
    
    @NSManaged var name: String
    @NSManaged var id: NSNumber
    @NSManaged var imagePath: String?
    @NSManaged var movies: [Movie]

    
    //MARK: Initialisers
    
//    init(dictionary: [String : AnyObject]) {
//        name = dictionary[Keys.Name] as! String
//        id = dictionary[Keys.ID] as! Int
//        imagePath = dictionary[Keys.ProfilePath] as? String
//    }

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String:AnyObject], context: NSManagedObjectContext) {
        
        //Get the entity associated with the "Person" type from the Model file
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: context)!
        //Call the init method from the superclass, which inserts the object into the context
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        //Init the properties from the dictionary
        name = dictionary[Keys.Name] as! String
        id = dictionary[Keys.ID] as! Int
        imagePath = dictionary[Keys.ProfilePath] as? String
    }
    
    var image: UIImage? {
        get {
            return TheMovieDB.Caches.imageCache.imageWithIdentifier(imagePath)
        }
        set {
            TheMovieDB.Caches.imageCache.storeImage(image, withIdentifier: imagePath!)
        }
    }
}
