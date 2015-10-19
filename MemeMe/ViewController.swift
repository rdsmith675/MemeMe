//
//  ViewController.swift
//  MemeMe
//
//  Created by Richard smith on 9/23/15.
//  Copyright © 2015 Richard Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
   let imagePicker = UIImagePickerController()
   var memeImage = UIImage()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       imagePicker.delegate = self
        
        setupTextField(topTextField)
        setupTextField(bottomTextField)
        
    }
    
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
          cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        subscribeToKeyboardNotifications()
        hideShareButton()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotification()
        
    }
    
    
    //image picker buttons
    

    @IBAction func pickACameraImage(sender: AnyObject) {
        
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    

    
    
    @IBAction func pickAnImage(sender: UIBarButtonItem) {

        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
        }
    
        
    //image picker delegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
                
             let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
             imagePickerView.image = image
        
             dismissViewControllerAnimated(true, completion: nil)
        
    }
     
     func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            
            dismissViewControllerAnimated(true, completion: nil)
            
           }

    
    
    //textfields
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
        return true
        
    }
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -4.0,
        
        
    ]

    func setupTextField(textField: UITextField) {
        
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        
    }

    // move keyboard out the way

    func keyboardWillPopUp(notification: NSNotification) {
    
        if bottomTextField.isFirstResponder() {
        
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
     }


    func keyboardWillHide(notification: NSNotification) {
        
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
        
     }


    func subscribeToKeyboardNotifications() {
    
     NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillPopUp:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
   }



    func unsubscribeFromKeyboardNotification() {
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    //save amem 
    
    func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, OGImage: imagePickerView.image!, memeImage: memeImage)
        
    }
    
    
    
    func generateMemedImage() -> UIImage
    {
        topToolbar.hidden = true
        bottomToolbar.hidden = true
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        
         topToolbar.hidden = false
         bottomToolbar.hidden = false
        
        return memeImage
    
    }
    
    

    

    
    //meme sharing 
    
   func hideShareButton() {
    if  (imagePickerView.image == nil) {
            shareButton.enabled = false
        }
    else {
        shareButton.enabled = true
    }
    }
    
    
    @IBAction func shareButtonAction(sender: AnyObject) {
        
         memeImage = generateMemedImage()
        
        let activityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        
        
        presentViewController(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = {(activity, completed, items, error) in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        
        }
    
    }
    
        
    @IBAction func cancelButtonAction(sender: AnyObject) {
        
        imagePickerView.image = UIImage()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}




