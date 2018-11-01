//
//  AppDelegate.swift
//  Passable-iOS
//
//  Created by Mark Philips on 9/20/18.
//  Copyright © 2018 Mark Philips. All rights reserved.
//

import UIKit
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var databaseName : String? = "app-database"
    var databasePath : String?
    var users : [Account] = []


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Declare & initialize the documents path and directory variables
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]
        
        // Initialize the database path using the documents directory variable
        databasePath = documentsDir.appending("/" + databaseName!)
        
        // Call the methods to check for and read from the database (and create if necessary)
        checkAndCreateDB()
        readDataFromDB()
        
        return true
    }
    
    /**
     * Function that is responsible for check whether or not the database file exists. If it doesn't it creates it.
     */
    func checkAndCreateDB() {
        var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
        
        if success { return }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
    }
    
    /**
     * Function that is responsible for reading data from the database
     */
    func readDataFromDB() {
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        // Open connection to the database
        if (sqlite3_open(self.databasePath, &db) == SQLITE_OK) {
            // Run a transaction by creating an SQLite object & querying the database
            var queryStatement : OpaquePointer? = nil
            var queryStatementString : String = "select * from users"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                //Iterate over the rows int the database table
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    // Retrieve the data object
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let col_social_name = sqlite3_column_text(queryStatement, 1)
                    let col_user_name = sqlite3_column_text(queryStatement, 2)
                    let col_user_pass = sqlite3_column_text(queryStatement, 3)
                    let col_glyph = sqlite3_column_text(queryStatement, 4)
                    
                    // Convert the columns into their string counterparts
                    let socialName = String(cString: col_social_name!)
                    let userName = String(cString: col_user_name!)
                    let userPass = String(cString: col_user_pass!)
                    let glyph = String(cString: col_glyph!)
                    
                    //Declare & initialize the data object & add it to the array of users
                    let data : Account = Account.init()
                    data.initWithData(socialMedia: socialName, username: userName, userPass: userPass, glyph: glyph)
                    users.append(data)
                    
                    // For debugging purposes
                    print("Query Result: \(socialName) | \(userName) | \(userPass) | \(glyph)")
                }
                // Close the query statement
                sqlite3_finalize(queryStatement)
            } else {
                print("Select statement couldn't be prepared")
            }
            // Close the database connection
            sqlite3_close(db)
        } else {
            print("Unable to open connection to database")
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

