//
//  MemeEditorViewController.swift
//  MemeMe_app
//
//  Created by Alfredo M. on 1/14/17.
//  Copyright © 2017 Alfredo. All rights reserved.
//

import UIKit


class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let textFieldDelegate = TextFieldDelegate()
    
    let memeTextAttribute:[String:Any] = [NSStrokeColorAttributeName: UIColor.black,
                                          NSForegroundColorAttributeName: UIColor.white,
                                          NSFontAttributeName:UIFont (name: "HelveticaNeue-CondensedBlack", size: 40)!,
                                          NSStrokeWidthAttributeName: -3.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        topTextField.defaultTextAttributes = memeTextAttribute
        topTextField.delegate = textFieldDelegate
        topTextField.text = "TOP"
        topTextField.textAlignment = NSTextAlignment.center
        
        bottomTextField.defaultTextAttributes = memeTextAttribute
        bottomTextField.delegate = textFieldDelegate
        bottomTextField.text = "BOTTOM"
        bottomTextField.textAlignment = NSTextAlignment.center
        
        shareButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyBoardNotifications()
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func shareMemedImage(_ sender: UIButton) {
        
        let activityItem: [Any] = [self.generateMemedImage() as Any]
        let activityViewController = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
        navigationController?.present(activityViewController, animated: true) {
        }
        activityViewController.completionWithItemsHandler =   {
            (activity, success, items, error) in
            if(success && error == nil){
                //Do work
                self.save()
                self.dismiss(animated: true, completion: nil);
            }
            else if (error != nil){
                //log the error
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String : Any]){
        
        //let image = didFinishPickingMediaWithInfo.UIImagePickerControllerOrignalImage;
        if let image = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImage.contentMode = UIViewContentMode.center
            memeImage.contentMode = UIViewContentMode.scaleAspectFill
            memeImage.image = image
            
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    func subscribeToKeyBoardNotifications(){
        NotificationCenter.default.addObserver(self, selector:  #selector(MemeEditorViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification){
        if topTextField.isEditing == true {
            return
        }
        self.view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y =  0
    }
    
    func getKeyboardHeight(_ notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue //of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    func save() {
        //Ceate the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeImage.image!, memedImage: generateMemedImage())
        // Add it to the memes array in the Application Delegate
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }
    
    
    func generateMemedImage() -> UIImage{
        
        let origin = toolbar.frame.origin.y
 
        toolbar.frame.origin.y = 0 - toolbar.frame.size.height

        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        toolbar.frame.origin.y = origin
        
        return memedImage
    }

}

