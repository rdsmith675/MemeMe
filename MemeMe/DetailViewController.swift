//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Richard smith on 12/3/15.
//  Copyright © 2015 Richard Smith. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    var detailMeme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        detailImage.image = detailMeme.memeImage
        
        self.tabBarController?.tabBar.hidden = true
    
    }
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }

    
}
