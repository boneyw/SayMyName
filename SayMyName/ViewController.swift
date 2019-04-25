//
//  ViewController.swift
//  SayMyName
//
//  Created by william boney on 4/21/19.
//  Copyright © 2019 william boney. All rights reserved.
// ContactsUI.framework

import UIKit
import AddressBookUI
import ContactsUI

class ViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate, CNContactPickerDelegate {

    
    @IBOutlet weak var forenameField: UITextField!
    
    @IBOutlet weak var surnameField: UITextField!
    
    
    
    @IBAction func getContact(_ sender: Any) {
        
        if (CNContactStore.authorizationStatus(for: .contacts) == CNAuthorizationStatus.denied ||
            CNContactStore.authorizationStatus(for: .contacts) == CNAuthorizationStatus.restricted){ print("Denied");
        }else if (CNContactStore.authorizationStatus(for: .contacts) == CNAuthorizationStatus.authorized){ self.showPeoplePicker()
        } else { //Undetermined
            let emptyDictionary: CFDictionary
            var addressBook = CNContactStore()
            print("requesting access...")
            
            //addressBook = obtainAddressbook(addressbookRef: ABAddressBookCreateWithOptions (emptyDictionary,nil))
            addressBook.requestAccess(for: .contacts) { success, error in if success {self.showPeoplePicker()
        }
        else {
            print("Denied")
            }
            }
        }
    }
    
    
    @IBAction func sayContact(_ sender: Any) {
        
        var personName = "You have chosen \(forenameField.text) \(surnameField.text)"
        TextToSpeech.SayText(input: personName)


        
    }
    
    func showPeoplePicker() {
        let contactPicker : CNContactPickerViewController =
            CNContactPickerViewController()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func obtainAddressbook(addressbookRef: Unmanaged<CNContactStore>!) ->
        CNContactStore? {
            if let adressbook = addressbookRef {
                return Unmanaged<NSObject>.fromOpaque(adressbook.toOpaque()).takeUnretainedValue() as? CNContactStore
            }
            return nil }
    
    func peoplePickerNavigationController(peoplePicker: CNContactPickerViewController!,didSelectPerson person: CNContact!) {
        
        if let forename = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as? NSString { forenameField.text = forename as String
        }
        if let surname = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as? NSString { surnameField.text = surname as String
    }
    }

}

