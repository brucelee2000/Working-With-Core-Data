//
//  ViewController.swift
//  Working With Core Data
//
//  Created by Yosemite on 1/24/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // +--- Database Preparation and Creation ---+
        // +-----------------------------------------+
        // Step1. Set up an App delegate to deal with core data
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        // Step2. Set up a Framework in which core database can be accessed
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        // Step3. Construct database(each entity is just like a table)
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        newUser.setValue("Rob", forKey: "username")
        newUser.setValue("pass", forKey: "password")
        newUser.setValue("Kyle", forKey: "username")
        newUser.setValue("pass2", forKey: "password")
        // Step4. Save the database
        var newUserError:NSError? = nil
        context.save(&newUserError)
        
        // +--- Database modification ---+
        // +-----------------------------+
        // Step1. Create the request to access the database
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        // Step2. Excute the request
        var requestError:NSError? = nil
        var results = context.executeFetchRequest(request, error: &requestError)
        println(results)
        // Step3. Process the result of the request
        if results?.count > 0 {
            for result:AnyObject in results! {
                println(result.valueForKey("username"))
                if let user = result.valueForKey("username") as? String {
                    if user == "Rob" {
                        // Step3.1 Delete an item from the table in the database
                        context.deleteObject(result as NSManagedObject)
                        println("\(user) is deleted")
                    } else if user == "Kyle" {
                        // Step3.2 Change an item of the table in the database
                        result.setValue("Kyle pass changed", forKey: "password")
                    }
                    
                }
                if let pass = result.valueForKey("password") as? String {
                    println(pass)
                }
            }
        } else {
            println("No database found")
        }
        
        // +--- Database search ---+
        // +-----------------------+
        // The predicate is used to constrain the selection of objects the receiver is to fetch
        // - %@ as the placeholder for argument "Kyle"
        request.predicate = NSPredicate(format: "username = %@", "Kyle")
        var newResults = context.executeFetchRequest(request, error: &requestError)
        if newResults?.count > 0 {
            println(newResults)
        } else {
            println("No matched database found")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

