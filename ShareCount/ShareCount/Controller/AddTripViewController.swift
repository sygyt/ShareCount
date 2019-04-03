//
//  AddTripViewController.swift
//  ShareCount
//
//  Created by Simon GAYET on 26/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class AddTripViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    
    @IBOutlet weak var nameTripTF: UITextField!
    @IBOutlet weak var changeImgBtn: UIButton!
    @IBOutlet weak var dateTripTF: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    let datePicker = UIDatePicker()
    let imagePicker = UIImagePickerController()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.dateTripTF.delegate = self
        self.endDateTextField.delegate = self
        datePicker.datePickerMode = .date

    }

    @IBAction func loadImageButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // UI textfield Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showDatePicker(label: textField)
    }
    
    //begin edit
    @IBAction func beginDtaeBeginEdit(_ sender: UITextField) {
        self.datePicker.minimumDate = nil
    }
    
    @IBAction func endDateEndEdit(_ sender: UITextField) {
        self.datePicker.maximumDate = nil
    }
    
    
    //end edit
    @IBAction func beginDateDidEndEdit(_ sender: Any) {
        self.datePicker.minimumDate = datePicker.date
    }
    
    @IBAction func endDateDidEndEdit(_ sender: Any) {
        self.datePicker.maximumDate = datePicker.date
    }
    
    
    
    func showDatePicker(label: UITextField){
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        label.inputAccessoryView = toolbar
        label.inputView = datePicker
        
    }
    
    @objc func donedatePicker(label: UITextField){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        if dateTripTF.isFirstResponder {
            dateTripTF.text = formatter.string(from: datePicker.date)
            dateTripTF.resignFirstResponder
        }
        else{
            endDateTextField.text = formatter.string(from: datePicker.date)
            endDateTextField.resignFirstResponder
        }
       
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        if dateTripTF.isFirstResponder{
            dateTripTF.resignFirstResponder
        }
        else {
            endDateTextField.resignFirstResponder
        }
        self.view.endEditing(true)
    }
    
    
    /// Add button controller
    ///
    /// - Parameter sender: <#sender description#>
    
    @IBAction func addButton(_ sender: Any) {
        let name = nameTripTF.text ?? ""
        let beginDate = dateTripTF.text ?? ""
        let endDate = endDateTextField.text ?? ""
        guard (name != "") && (beginDate != "") && (endDate != "") else { return }
        if let img =  myImageView.image?.jpegData(compressionQuality: 0.8) {
            let trip = Trips(context: CoreDataManager.context)
            trip.name = name
            trip.image = img
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            trip.beginDate = dateFormatter.date(from: beginDate)
            trip.endDate = dateFormatter.date(from: endDate)
            //self.saveNewTrip(withName: nameToSave, withImg : img as NSData)
        }
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
    
    
}
