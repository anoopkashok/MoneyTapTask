//
//  PersistantService.swift
//  MoneyTapTask
//
//  Created by Anoop on 13/10/18.
//  Copyright © 2018 Anoop. All rights reserved.
//

import Foundation
import CoreData

class PersistantService {
    
    static var context : NSManagedObjectContext = persistentContainer.viewContext


    private init(){
    
    }
    //Call this function to save a page to core data
    static func savePage(page: Page){
        
        let itemToSave: WikiPage = NSEntityDescription.insertNewObject(forEntityName: "WikiPage", into: context) as! WikiPage
       /* if let pageTitle = page.pageTitle {
            itemToSave.pageTitle = pageTitle

        }else{
            itemToSave.pageTitle = ""
        }
        
        if let pageId = page.pageID {
            itemToSave.pageID = pageId
            
        }else{
            itemToSave.pageID = ""
        }
        if let pageImageurl = page.pageImageUrl {
            itemToSave.pageImageUrl = pageImageurl
            
        }else{
            itemToSave.pageImageUrl = ""
        }
        
        if let pagedesc = page.pageDescription {
            itemToSave.pageDescription = pagedesc
            
        }else{
            itemToSave.pageDescription = ""
        }*/
        
        itemToSave.pageTitle = page.pageTitle
        itemToSave.pageID = page.pageID
        itemToSave.pageImageUrl = page.pageImageUrl
        itemToSave.pageDescription = page.pageDescription
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    //Function to get saved page list from core data
    static func getSavedPageList()->[WikiPage] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WikiPage")
        var wikipageArray = [WikiPage]()
        
        do {
            let results = try context.fetch(fetchRequest)
            if let  items = results as? [WikiPage]{
                wikipageArray = items
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return wikipageArray
    }
    
    //Call this function to delete already added entries from core data
    static func deleteAllEntries() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "WikiPage")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
        
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MoneyTapTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
