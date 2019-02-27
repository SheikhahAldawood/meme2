//
//  ViewController.swift
//  meme1
//
//  Created by sh da on 19/11/2018.
//  Copyright © 2018 sh da. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var bottomTextIsEditing = 0
    var upperTextIsEditing = 0
   /* let memeTextAttributes:[NSAttributedString.Key: Any] = [
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -5.4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField1.text = "TOP"
        self.textField2.text = "BOTTOM"
        textField1.defaultTextAttributes = memeTextAttributes
        textField2.defaultTextAttributes = memeTextAttributes
        self.textField1.textAlignment = .center
        self.textField2.textAlignment = .center
        
        // Do any additional setup after loading the view, typically from a nib.
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField(tf: textField1, text: "TOP")
        setupTextField(tf: textField2, text: "BOTTOM")
        textField1.delegate = self
        textField2.delegate = self
    }
    
    func setupTextField(tf: UITextField, text: String) {
        tf.defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -4.0,
        ]
        tf.textColor = UIColor.white
        tf.tintColor = UIColor.white
        tf.textAlignment = .center
        tf.text = text
        tf.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
     
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         //dismiss(animated: true, completion: nil)
        textField.resignFirstResponder()
        return true
    }
    
    //added
    @objc func keyboardWillShow(_ notification:Notification) {
        if view.frame.origin.y == 0 && bottomTextIsEditing == 1{
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if view.frame.origin.y != 0{
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight (_ notification : Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo! [UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    /*override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }*/

    func chooseImageFromCameraOrPhoto(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController ()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.isEnabled = true
            dismiss(animated: true, completion: nil)
            
        } else {
            print("Not able to get an image")
        
        }
        
        //dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
     /*struct Meme {
        var topText : String
        var bottomText : String
        var originalImage : UIImage
        var memedImage : UIImage
    }*/
    
    
    func save() -> Meme {
        // Create the meme
        let meme = Meme(topText: textField1.text!, bottomText: textField2.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        return meme
    }
    
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        toolBar.isHidden = true
        navBar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        toolBar.isHidden = false
        navBar.isHidden = false
        
        return memedImage
    }
    
    // added
    public func textFieldDidBeginEditing(_ textField: UITextField){
        if textField.tag == 1{
            if (textField.text == "TOP"){
                textField1.text = ""
            }
            upperTextIsEditing = 1
            bottomTextIsEditing = 0
        }else{
            if textField.text == "BOTTOM"{
                textField2.text = ""
            }
            upperTextIsEditing = 0
            bottomTextIsEditing = 1
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        //activityController.completionWithItemsHandler = { activity, completed, items, error in
        activityController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in

            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(activityController, animated: true, completion: nil)
    }
    
  /*  override var prefersStatusBarHidden: Bool {
        return true
    }*/
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

