//
//  AddTripViewController.swift
//  ShareCount
//
//  Created by Simon GAYET on 26/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit
import CoreData

class AddTripViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    
    @IBOutlet weak var nameTripTF: UITextField!
    @IBOutlet weak var changeImgBtn: UIButton!
    @IBOutlet weak var dateTripTF: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    let datePicker = UIDatePicker()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        imagePicker.delegate = self
    }

    @IBAction func loadImageButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTripTF.inputAccessoryView = toolbar
        dateTripTF.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTripTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    /// Add button controller
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func addButton(_ sender: Any) {
        if let nameToSave = nameTripTF.text  {
            if let img =  myImageView.image?.jpegData(compressionQuality: 0.8) {
                let trip = Trips(context: CoreDataManager.context)
                trip.name = nameToSave
                trip.image = img
                //self.saveNewTrip(withName: nameToSave, withImg : img as NSData)
            }
        }
    }
    
    //MARK: - Trips management -
    /// Saves the trip in the CoreData
    ///
    /// - Parameter name: The name of the trip
//    func saveNewTrip(withName name: String, withImg img: NSData) {
//
//
//        // création ogjet trip
//        let trip = Trips(context: CoreDataManager.context)
//        //modifier le nom
//        trip.name = name
//        trip.image = img as Data
//        do{
//            try context.save()
//
//        }
//        catch let error as NSError{
//            self.alert(error: error)
//            return
//        }
//    }
    
    /// Get the context
    ///
    /// - Parameters:
    ///   - errorMsg: <#errorMsg description#>
    ///   - userInfoMsg: <#userInfoMsg description#>
    /// - Returns: <#return value description#>
    func getContext(errorMsg : String, userInfoMsg: String = "Could not retrieve data context") -> NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            self.alert(withTitle: errorMsg, andMessage: userInfoMsg)
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    
    /// Show an alert with two messages
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - msg: <#msg description#>
    func alert(withTitle title : String, andMessage msg : String = ""){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title:"Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        present(alert, animated:true)
    }
    
    /// Show an alert of the error in parameter
    ///
    /// - Parameter error: <#error description#>
    func alert(error: NSError){
        self.alert(withTitle: "\(error)", andMessage:"\(error.userInfo)")
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        myImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // textField delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let text = textField.text{
            if text != ""{
                textField.resignFirstResponder()
                return true
            }
        }
        return false
        
    }
    
}
