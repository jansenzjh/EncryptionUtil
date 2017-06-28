//
//  InformationTableViewController.swift
//  PPMS
//
//  Created by Jansen on 2/19/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyUserDefaults
import MessageUI
import Alertift

enum TextTypes: String {
    
    case Default = "Default"
    case Contact = "Contact"
    case Password = "Password"
    case Event = "Event"
    case Website = "Website"
    
}

class InformationTableViewController: UITableViewController,  MFMessageComposeViewControllerDelegate{
    
    let appLink = "https://goo.gl/9J7Lgk"
    @IBOutlet weak var btnEncryptMsg: UIBarButtonItem!
    @IBAction func btnEncryptMsg(_ sender: UIBarButtonItem) {
        
        Alertift.alert(title: "Message", message: "Please enter the message you want to encrypt")
            .textField { textField in
                textField.placeholder = "message"
            }
            .action(.cancel("Cancel"))
            .action(.default("OK")) { _, _, textFields in
                let text = textFields?.first?.text ?? ""
                var encodeText = Enigma().encode(text)
                encodeText = encodeText + "***** download " + self.appLink + " to view message"
                if MFMessageComposeViewController.canSendText(){
                    let messageVC = MFMessageComposeViewController()
                    messageVC.body = encodeText
                    messageVC.messageComposeDelegate = self;
                    
                    self.present(messageVC, animated: false, completion: nil)
                    
                }else{
                    Alertift.alert(title:"Warning!", message: "Your device did not suppport messaging!").action(.default("OK")).show()
                }
            }
            .show()
    }
    
    @IBOutlet weak var btnDecryptMsg: UIBarButtonItem!
    @IBAction func btnDecryptMsg(_ sender: UIBarButtonItem) {
        Alertift.alert(title: "Message", message: "Please enter the message you want to decrypt")
            .textField { textField in
                textField.placeholder = "message"
            }
            .action(.cancel("Cancel"))
            .action(.default("OK")) { _, _, textFields in
                var text = textFields?.first?.text ?? ""
                if let idx = text.index(of: "*****"){
                
                   text = text.substring(to: idx)
                }
                let decodeText = Enigma().decode(text)
                Alertift.alert(title:"Message", message: decodeText)
                    .action(.default("OK"))
                    .action(.default("Reply")) { _, _, textFields in
                        if MFMessageComposeViewController.canSendText(){
                            let messageVC = MFMessageComposeViewController()
                            messageVC.messageComposeDelegate = self;
                            
                            self.present(messageVC, animated: false, completion: nil)
                            
                        }else{
                            Alertift.alert(title:"Warning!", message: "Your device did not suppport messaging!").action(.default("OK")).show()
                        }
                    }
                    .show()
            }
            .show()
    }
    
    
    var InformationList = [Information]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.initLockScreen()
        
        Defaults[.IsPremiumAccess] = ProjectProducts.store.isProductPurchased(ProjectProducts.PremiumAccessProduct)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LoadData()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.InformationList.count
    }
    
    func initLockScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "calculatorUIID")
        self.present(controller, animated: false, completion: nil)
    }
    
    func LoadData() {
        let realm = try! Realm()
        
        let cl = realm.objects(Information.self)
        self.InformationList = Array(cl)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "informationCell", for: indexPath) as! InformationTableViewCell
        
        // Configure the cell...
        let info = InformationList[indexPath.row]
        cell.informationGID = info.Guid
        cell.lblDesc?.text = info.Description
        switch info.TypeId {
        case "Default":
            cell.textLabel?.text = info.Text
            //cell.detailTextLabel?.text = info.Text
            cell.imageView?.image = UIImage.fontAwesomeIcon(name: .file, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        case "Contact":
            cell.textLabel?.text = info.FullName
            cell.detailTextLabel?.text = info.Home + " " + info.Mobile + " " + info.Work
            cell.imageView?.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        case "Password":
            cell.textLabel?.text = info.Title
            cell.detailTextLabel?.text = info.UserName + "/" + info.Password
            cell.imageView?.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        case "Event":
            cell.textLabel?.text = info.Description
            cell.detailTextLabel?.text = info.StartDate.toString(dateFormat: "MM/dd/yy") + " - " + info.EndDate.toString(dateFormat: "MM/dd/yy")
            cell.imageView?.image = UIImage.fontAwesomeIcon(name: .calendarPlusO, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        case "Website":
            cell.textLabel?.text = info.Website
            //cell.detailTextLabel?.text = info.Text
            cell.imageView?.image = UIImage.fontAwesomeIcon(name: .safari, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        default:
            cell.textLabel?.text = info.Text
            //cell.detailTextLabel?.text = info.Text
            cell.imageView?.image = UIImage.fontAwesomeIcon(name: .file, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let obj = self.InformationList[indexPath.row]
            Information().Delete(guid: obj.Guid)
            InformationList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func initUI(){
        if let tabBarItems = self.tabBarController?.tabBar.items {
            for item in tabBarItems {
                if item.title == "Text" {
                    item.image = UIImage.fontAwesomeIcon(name: .font, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
                }else if item.title == "Files" {
                    item.image = UIImage.fontAwesomeIcon(name: .file, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
                }else if item.title == "Media" {
                    item.image = UIImage.fontAwesomeIcon(name: .fileVideoO, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
                }else if item.title == "Browser" {
                    item.image = UIImage.fontAwesomeIcon(name: .safari, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
                }else if item.title == "Setting" {
                    item.image = UIImage.fontAwesomeIcon(name: .gears, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
                }
            }
        }
        btnDecryptMsg.image = UIImage.fontAwesomeIcon(name: .envelopeOpenO, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        btnEncryptMsg.image = UIImage.fontAwesomeIcon(name: .envelopeO, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "editInformationSegue"){
            let destView = segue.destination as! EditInformationViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            
            let informationObj = InformationList[(indexPath?.row)!]
            
            let theDtl = Information()
            theDtl.Guid = informationObj.Guid
            theDtl.TypeId = informationObj.TypeId
            theDtl.Text = informationObj.Text
            theDtl.Contact = informationObj.Contact
            theDtl.FullName = informationObj.FullName
            theDtl.Company = informationObj.Company
            theDtl.Mobile = informationObj.Mobile
            theDtl.Home = informationObj.Home
            theDtl.Work = informationObj.Work
            theDtl.Email = informationObj.Email
            theDtl.Title = informationObj.Title
            theDtl.UserName = informationObj.UserName
            theDtl.Password = informationObj.Password
            theDtl.Description = informationObj.Description
            theDtl.StartDate = informationObj.StartDate
            theDtl.EndDate = informationObj.EndDate
            theDtl.Website = informationObj.Website
            theDtl.Notes = informationObj.Notes
            
            destView.informationObj = theDtl
        }else if(segue.identifier == "addinformationSegue") {
            
            //let destView = segue.destination as! EditInformationViewController
            
            
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    
}
