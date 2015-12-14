//
//  TableViewController.swift
//  MemeMe
//
//  Created by Richard smith on 11/23/15.
//  Copyright © 2015 Richard Smith. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    
    var memes: [Meme]! {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    
    var appDel: AppDelegate {
        return (UIApplication.sharedApplication().delegate as! AppDelegate)
    }
    
    override func viewWillAppear(animated: Bool) {
    tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDel.memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Meme Cell", forIndexPath: indexPath)
    let tableMeme = self.memes[indexPath.row]
    tableView.rowHeight = 120
    
    cell.imageView?.image = tableMeme.memeImage
    cell.textLabel?.text = "\(tableMeme.topText)...\(tableMeme.bottomText)"
    
    return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath
        indexPath: NSIndexPath) {
            
            //Grab the DetailVC from Storyboard
            let detailObject: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController")
            let detailVC = detailObject as! DetailViewController
            
            //Populate view controller with data from the selected item
            detailVC.detailMeme = self.memes[indexPath.row]
            
            //Present the view controller using navigation
            self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            tableView.beginUpdates()
            
            appDel.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            tableView.endUpdates()
            self.tableView.reloadData()
            
                }
        
   }

}