# Working-With-Core-Data
Database Preparation and Creation
---------------------------------
* **Step 1. Set up an App delegate to deal with core data**

        // Step1. Set up an App delegate to deal with core data
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
* **Step 2. Set up a Framework in which core database can be accessed**

        // Step2. Set up a Framework in which core database can be accessed
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
* **Step 3. Construct database(each entity is just like a table)**

        // Step3. Construct database(each entity is just like a table)
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        newUser.setValue("Rob", forKey: "username")
        newUser.setValue("pass", forKey: "password")
        
* **Step 4. Save the database**

        // Step4. Save the database
        var newUserError:NSError? = nil
        context.save(&newUserError)
        
Database item access/delete/modify
----------------------------------
* **Step 1. Create the request to access the database**

        // Step1. Create the request to access the database
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
* **Step 2. Excute the request**

        var requestError:NSError? = nil
        var results = context.executeFetchRequest(request, error: &requestError)
        println(results)
        
* **Step 3. Process the result of the request**

        // Step3. Process the result of the request
        if results?.count > 0 {
            for result:AnyObject in results! {
                println(result.valueForKey("username"))
                if let pass = result.valueForKey("password") as? String {
                    println(pass)
                }
            }
        } else {
            println("No database found")
        }
        
* **Step 3. Delete/modify an item from database**

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
        
Database search
---------------

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
        
     
