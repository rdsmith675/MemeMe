//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Richard smith on 11/23/15.
//  Copyright © 2015 Richard Smith. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
        }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Meme Cell", forIndexPath: indexPath)
        let tableMeme = self.memes[indexPath.row]
        
        // Configure the cell...
        cell.imageView?.image = tableMeme.memeImage
        
        
        return cell
    }
    
}