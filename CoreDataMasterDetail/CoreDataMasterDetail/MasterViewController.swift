//
//  MasterViewController.swift
//  MasterDetail-CoreData-1
//
//  Created by Jason on 3/9/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

/**
 * Five steps to using Core Data to persist MasterDetail:
 *
 * 1. Add a convenience method that find the shared context
 * 2. Add fetchAllEvents()
 * 3. Invoke fetchAllevents in viewDidLoad()
 * 4. Create an Event object in insertNewObject()
 * 5. Save the context in insertNewObject()
 *
 */

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    //MARK: Properties
    var events = [Event]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton

        events = fetchAllEvents()
    }

    func insertNewObject(sender: AnyObject) {

        let newEvent = Event(context: sharedContext)

        // Step 5: Save the context (and check for an error)
        // (see the actorPicker(:didPickActor:) method for an example
        
        dispatch_async(dispatch_get_main_queue()) {
            self.events.append(newEvent)
            
            do {
                try self.sharedContext.save()
            } catch let error as NSError {
                print("Error saving contect: \(error.localizedDescription)")
            }
            return
        }
        
        
        tableView.reloadData()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showDetail" {

        if let indexPath = self.tableView.indexPathForSelectedRow {
            let object = events[indexPath.row]
                (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let event = events[indexPath.row]

        cell.textLabel!.text = event.timeStamp.description

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == .Delete {
            // How do we delete a managed object? An interesting, open question.
        }
    }

    // MARK: - Core Data Fetch Helpers
    
    var sharedContext : NSManagedObjectContext {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate.managedObjectContext
    }
    
    func fetchAllEvents() -> [Event] {
        let fetchRequest = NSFetchRequest(entityName: "Event")
        
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [Event]
        } catch {
            return [Event]()
        }
    }
}

