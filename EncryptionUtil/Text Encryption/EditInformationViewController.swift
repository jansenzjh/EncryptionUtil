//
//  EditInformationViewController.swift
//  EncryptionUtil
//
//  Created by Jansen on 6/16/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import UIKit
import Eureka
import FontAwesome
import RealmSwift

class EditInformationViewController: FormViewController {

    var informationObj: Information? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if informationObj == nil {
            informationObj = Information()
        }
        
        
        self.buildForm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func syncObject() {
        if informationObj == nil{
            informationObj = Information()
        }
        
        let valuesDictionary = form.values()
        
        var strVal = valuesDictionary["Guid"]
        if (strVal as? String != nil) {
            informationObj?.Guid = strVal as! String
        }
        
        strVal = valuesDictionary["Text"]
        if (strVal as? String != nil) {
            informationObj?.Text = strVal as! String
        }
        strVal = valuesDictionary["FullName"]
        if (strVal as? String != nil) {
            informationObj?.FullName = strVal as! String
        }
        strVal = valuesDictionary["Company"]
        if (strVal as? String != nil) {
            informationObj?.Company = strVal as! String
        }
        strVal = valuesDictionary["Mobile"]
        if (strVal as? String != nil) {
            informationObj?.Mobile = strVal as! String
        }
        strVal = valuesDictionary["Home"]
        if (strVal as? String != nil) {
            informationObj?.Home = strVal as! String
        }
        strVal = valuesDictionary["Work"]
        if (strVal as? String != nil) {
            informationObj?.Work = strVal as! String
        }
        strVal = valuesDictionary["Email"]
        if (strVal as? String != nil) {
            informationObj?.Email = strVal as! String
        }
        strVal = valuesDictionary["Title"]
        if (strVal as? String != nil) {
            informationObj?.Title = strVal as! String
        }
        strVal = valuesDictionary["UserName"]
        if (strVal as? String != nil) {
            informationObj?.UserName = strVal as! String
        }
        strVal = valuesDictionary["Password"]
        if (strVal as? String != nil) {
            informationObj?.Password = strVal as! String
        }
        strVal = valuesDictionary["Description"]
        if (strVal as? String != nil) {
            informationObj?.Description = strVal as! String
        }
        strVal = valuesDictionary["StartDate"]
        if (strVal as? Date != nil) {
            informationObj?.StartDate = strVal as! Date
        }
        strVal = valuesDictionary["EndDate"]
        if (strVal as? Date != nil) {
            informationObj?.EndDate = strVal as! Date
        }
        strVal = valuesDictionary["Website"]
        if (strVal as? String != nil) {
            informationObj?.Website = strVal as! String
        }
        strVal = valuesDictionary["Notes"]
        if (strVal as? String != nil) {
            informationObj?.Notes = strVal as! String
        }
        
        strVal = valuesDictionary["TypeId"]
        if (strVal as? String != nil) {
            informationObj?.TypeId = strVal as! String
        }
        
    }
    
    func Save() {
        syncObject()
        informationObj?.Save()
        
    }


    func buildForm() {
        form +++ Section("Default")
            <<< PushRow<String>("TypeId") {
                $0.title = "Type"
                $0.options = ["Default","Contact","Password", "Event", "Website"]
                $0.value = informationObj?.TypeId
                $0.selectorTitle = "Choose a Type"
                $0.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .userCircle, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            <<< TextRow("Text"){ row in
                row.title = "Text"
                row.placeholder = "Any Text"
                if (informationObj?.Text.characters.count)! > 0 {
                    row.value = informationObj?.Text
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .fileTextO, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            
            +++ Section("Contact")
            <<< TextRow("FullName"){ row in
                row.title = "Full Name"
                row.placeholder = "Full Name"
                if (informationObj?.FullName.characters.count)! > 0 {
                    row.value = informationObj?.FullName
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            <<< TextRow("Mobile"){ row in
                row.title = "Mobile"
                row.placeholder = "Mobile"
                if (informationObj?.Mobile.characters.count)! > 0 {
                    row.value = informationObj?.Mobile
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .mobile, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            <<< TextRow("Home"){ row in
                row.title = "Home"
                row.placeholder = "Home"
                if (informationObj?.Home.characters.count)! > 0 {
                    row.value = informationObj?.Home
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .phone, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            <<< TextRow("Work"){ row in
                row.title = "Work"
                row.placeholder = "Work"
                if (informationObj?.Work.characters.count)! > 0 {
                    row.value = informationObj?.Work
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .phoneSquare, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            <<< TextRow("Email"){ row in
                row.title = "Email"
                row.placeholder = "Email"
                if (informationObj?.Email.characters.count)! > 0 {
                    row.value = informationObj?.Email
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .envelope, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            
            
            +++ Section("Password")
            <<< TextRow("Title"){ row in
                row.title = "Title"
                row.placeholder = "Title"
                if (informationObj?.Title.characters.count)! > 0 {
                    row.value = informationObj?.Title
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .file, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            <<< TextRow("UserName"){ row in
                row.title = "UserName"
                row.placeholder = "UserName"
                if (informationObj?.UserName.characters.count)! > 0 {
                    row.value = informationObj?.UserName
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            <<< TextRow("Password"){ row in
                row.title = "Password"
                row.placeholder = "Password"
                if (informationObj?.Password.characters.count)! > 0 {
                    row.value = informationObj?.Password
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            
            +++ Section("Event")
            <<< TextRow("Description"){ row in
                row.title = "Description"
                row.placeholder = "Description"
                if (informationObj?.Description.characters.count)! > 0 {
                    row.value = informationObj?.Description
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .calendar, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            <<< DateInlineRow("StartDate"){ row in
                row.title = "StartDate"
                row.value = informationObj?.StartDate as Date?
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .calendar, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            <<< DateInlineRow("EndDate"){ row in
                row.title = "EndDate"
                row.value = informationObj?.EndDate as Date?
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .calendar, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            
            +++ Section("Others")
            <<< TextRow("Website"){ row in
                row.title = "Website"
                row.placeholder = "Website"
                if (informationObj?.Website.characters.count)! > 0 {
                    row.value = informationObj?.Website
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .safari, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            
            <<< TextAreaRow("Notes"){ row in
                row.title = "Notes"
                row.placeholder = "Notes"
                if (informationObj?.Notes.characters.count)! > 0 {
                    row.value = informationObj?.Notes
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .stickyNote, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            
            +++ Section("Actions")
            <<< ButtonRow("Save"){
                $0.title = "Save"
                }.onCellSelection { [weak self] (cell, row) in
                    self?.Save()
                    _ = self?.navigationController?.popViewController(animated: true)
        }
    }

}
