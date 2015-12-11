//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Richard smith on 11/25/15.
//  Copyright © 2015 Richard Smith. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    
    
    var memes: [Meme]! {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(animated: Bool) {
        self.collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(MemeCollectionViewCell.self, forCellWithReuseIdentifier: "Collection Meme Cell")

    }


   
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Collection Meme Cell", forIndexPath: indexPath) as!
        MemeCollectionViewCell
        
    
        let collectionMeme = self.memes[indexPath.item]
        let imageView = UIImageView(image: collectionMeme.memeImage)
        cell.backgroundView = imageView
        
        
        return cell
    }

     @IBAction func newMemeCollection(sender: AnyObject) {
        
        performSegueWithIdentifier("NewMemeSegue", sender: self)
        

    }
    
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //Grab the DetailVC from Storyboard
        let detailObject: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController")
        let detailVC = detailObject as! DetailViewController
        
        //Populate view controller with data from the selected item
        detailVC.detailMeme = self.memes[indexPath.item]
        
        //Present the view controller using navigation
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
 
}
