//
//  SettingViewController.swift
//  EncryptionUtil
//
//  Created by Jansen on 6/22/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import UIKit
import Eureka
import SwiftyUserDefaults
import MessageUI
import SwiftyStoreKit
import NotificationBanner

enum RegisteredPurchase: String {
    
    case PremiumAccessMonthly = "premiumAccessMonthly"
    case PremiumAccessYearly = "PremiumAccessYearly"

}

class SettingViewController: FormViewController, MFMailComposeViewControllerDelegate {

    let appBundleId = "com.jzsoft.encryptionUtil"
    let Shared_Key = "91bbc3dd68fb4371bbf0db443cd61d22"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initForm()
        
//        verifyPurchase(RegisteredPurchase.PremiumAccessMonthly)
//        verifyPurchase(RegisteredPurchase.PremiumAccessYearly)
//        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func initForm(){
        form +++ Section("Security")
            <<< PasswordRow("Password"){ row in
                row.title = "Password"
                row.placeholder = "Password"
                row.cell.textField.keyboardType = UIKeyboardType.numberPad	
                
                if (Defaults[.UserPassword]?.characters.count)! > 0 {
                    row.value = Defaults[.UserPassword]
                }
                row.baseCell.imageView?.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.gray, size: CGSize(width: 25, height: 25))
            }
            +++ Section("Upgrade")
            <<< ButtonRow("Upgrade"){
                $0.title = "Upgrade to Premium Access"
                }.onCellSelection { [weak self] (cell, row) in
                    self?.showIAP()
            }
//            <<< ButtonRow("PremiumAccessMonthly"){
//                $0.tag = RegisteredPurchase.PremiumAccessMonthly.rawValue
//                $0.title = "0.49 USD/mo Monthly billing"
//                }.onCellSelection { [weak self] (cell, row) in
//                    self?.subscribe(RegisteredPurchase.PremiumAccessMonthly)
//            }
//            <<< ButtonRow("PremiumAccessYearly"){
//                $0.tag = RegisteredPurchase.PremiumAccessYearly.rawValue
//                $0.title = "4.99 USD/yr Yearly billing"
//                }.onCellSelection { [weak self] (cell, row) in
//                    self?.subscribe(RegisteredPurchase.PremiumAccessYearly)
//            }
//            <<< ButtonRow("btnRestore"){
//                $0.title = "Restore previous purchases"
//                }.onCellSelection { [weak self] (cell, row) in
//                    self?.restore()
//            }
            
            
            
            //
            +++ Section("About/Feedback")
            <<< ButtonRow("btnFeatureRowTag"){
                $0.title = "Feature Request"
                }.onCellSelection { [weak self] (cell, row) in
                    //open mail form
                    self?.EmailFeature()
            }
            +++ Section("Actions")
            <<< ButtonRow("Save"){
                $0.title = "Save"
                }.onCellSelection { [weak self] (cell, row) in
                    self?.Save()
                    let banner = NotificationBanner(title: "Save!", subtitle: "Save Successfully!", style: .success)
                    banner.show()
        }
    }
    
    func showIAP(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "iapTableViewID")
        self.present(controller, animated: true, completion: nil)
    }
    
//    func updatePurchaseButtonText(purchase: RegisteredPurchase, isPurchase: Bool){
//        
//        let row = form.rowBy(tag: purchase.rawValue)
//        
//        if isPurchase {
//            row?.title = (row?.title)! + " ✔"
//            row?.updateCell()
//        }
//        
//    }
    
    //MARK: Subscription
//    func subscribe(_ purchase: RegisteredPurchase){
//        NetworkActivityIndicatorManager.networkOperationStarted()
//        SwiftyStoreKit.purchaseProduct(purchase.rawValue, atomically: true) { result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//            
//            if case .success(let purchase) = result {
//                // Deliver content from server, then:
//                
//                Defaults[purchase.productId] = true
//                
//                if purchase.needsFinishTransaction {
//                    SwiftyStoreKit.finishTransaction(purchase.transaction)
//                }
//            }
//            if let alert = self.alertForPurchaseResult(result) {
//                self.showAlert(alert)
//            }
//        }
//    }
//    
//    func restore(){
//        NetworkActivityIndicatorManager.networkOperationStarted()
//        SwiftyStoreKit.restorePurchases(atomically: true) { results in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//            
//            for purchase in results.restoredPurchases where purchase.needsFinishTransaction {
//                // Deliver content from server, then:
//                Defaults[purchase.productId] = true
//                SwiftyStoreKit.finishTransaction(purchase.transaction)
//                
//            }
//            self.showAlert(self.alertForRestorePurchases(results))
//        }
//    }
//    
//    
//    func verifyReceipt(completion: @escaping (VerifyReceiptResult) -> Void) {
//        
//        let appleValidator = AppleReceiptValidator(service: .production)
//        let password = Shared_Key
//        SwiftyStoreKit.verifyReceipt(using: appleValidator, password: password, completion: completion)
//    }
//    
//    
//    func verifyPurchase(_ purchase: RegisteredPurchase) {
//        
//        NetworkActivityIndicatorManager.networkOperationStarted()
//        verifyReceipt { result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//            
//            switch result {
//            case .success(_):
//                
//                //let productId = purchase.rawValue
//                
//                switch purchase {
//                case .PremiumAccessMonthly:
//                    Defaults[RegisteredPurchase.PremiumAccessMonthly.rawValue] = true
//                    Defaults[RegisteredPurchase.PremiumAccessYearly.rawValue] = false
//                case .PremiumAccessYearly:
//                    Defaults[RegisteredPurchase.PremiumAccessMonthly.rawValue] = false
//                    Defaults[RegisteredPurchase.PremiumAccessYearly.rawValue] = true
//                
//                }
//                self.updatePurchaseButtonText(purchase: purchase, isPurchase: true)
//                
//            case .error:
//                Defaults[RegisteredPurchase.PremiumAccessMonthly.rawValue] = false
//                Defaults[RegisteredPurchase.PremiumAccessYearly.rawValue] = false
//            }
//        }
//    }
    
    func Save(){
        let valuesDictionary = form.values()
        
        let strVal = valuesDictionary["Password"]
        if (strVal as? String != nil) {
            Defaults[.UserPassword] = strVal as? String
        }
    }
    
    //MARK: Email
    
    
    func EmailFeature() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = configuredMailFeature()
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailBug() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["jansother@gmail.com"])
        mailComposerVC.setSubject("Bug Report")
        mailComposerVC.setMessageBody("I have some issue on your app, here is how you can recreate the bug: \n", isHTML: false)
        
        return mailComposerVC
    }
    
    func configuredMailFeature() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["jansother@gmail.com"])
        mailComposerVC.setSubject("Feature Request")
        mailComposerVC.setMessageBody("I want to see this in a future update: ", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}



// MARK: User facing alerts
extension SettingViewController {
    
//    func alertWithTitle(_ title: String, message: String) -> UIAlertController {
//        
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        return alert
//    }
//    
//    func showAlert(_ alert: UIAlertController) {
//        guard self.presentedViewController != nil else {
//            self.present(alert, animated: true, completion: nil)
//            return
//        }
//    }
//    
//    func alertForProductRetrievalInfo(_ result: RetrieveResults) -> UIAlertController {
//        
//        if let product = result.retrievedProducts.first {
//            let priceString = product.localizedPrice!
//            return alertWithTitle(product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
//        } else if let invalidProductId = result.invalidProductIDs.first {
//            return alertWithTitle("Could not retrieve product info", message: "Invalid product identifier: \(invalidProductId)")
//        } else {
//            let errorString = result.error?.localizedDescription ?? "Unknown error. Please contact support"
//            return alertWithTitle("Could not retrieve product info", message: errorString)
//        }
//    }
//    
//    // swiftlint:disable cyclomatic_complexity
//    func alertForPurchaseResult(_ result: PurchaseResult) -> UIAlertController? {
//        switch result {
//        case .success(let purchase):
//            print("Purchase Success: \(purchase.productId)")
//            return alertWithTitle("Thank You", message: "Purchase completed")
//        case .error(let error):
//            print("Purchase Failed: \(error)")
//            switch error.code {
//            case .unknown: return alertWithTitle("Purchase failed", message: "Unknown error. Please contact support")
//            case .clientInvalid: // client is not allowed to issue the request, etc.
//                return alertWithTitle("Purchase failed", message: "Not allowed to make the payment")
//            case .paymentCancelled: // user cancelled the request, etc.
//                return nil
//            case .paymentInvalid: // purchase identifier was invalid, etc.
//                return alertWithTitle("Purchase failed", message: "The purchase identifier was invalid")
//            case .paymentNotAllowed: // this device is not allowed to make the payment
//                return alertWithTitle("Purchase failed", message: "The device is not allowed to make the payment")
//            case .storeProductNotAvailable: // Product is not available in the current storefront
//                return alertWithTitle("Purchase failed", message: "The product is not available in the current storefront")
//            case .cloudServicePermissionDenied: // user has not allowed access to cloud service information
//                return alertWithTitle("Purchase failed", message: "Access to cloud service information is not allowed")
//            case .cloudServiceNetworkConnectionFailed: // the device could not connect to the nework
//                return alertWithTitle("Purchase failed", message: "Could not connect to the network")
//            case .cloudServiceRevoked: // user has revoked permission to use this cloud service
//                return alertWithTitle("Purchase failed", message: "Cloud service was revoked")
//            }
//        }
//    }
//    
//    func alertForRestorePurchases(_ results: RestoreResults) -> UIAlertController {
//        
//        if results.restoreFailedPurchases.count > 0 {
//            print("Restore Failed: \(results.restoreFailedPurchases)")
//            return alertWithTitle("Restore failed", message: "Unknown error. Please contact support")
//        } else if results.restoredPurchases.count > 0 {
//            print("Restore Success: \(results.restoredPurchases)")
//            return alertWithTitle("Purchases Restored", message: "All purchases have been restored")
//        } else {
//            print("Nothing to Restore")
//            return alertWithTitle("Nothing to restore", message: "No previous purchases were found")
//        }
//    }
//    
//    func alertForVerifyReceipt(_ result: VerifyReceiptResult) -> UIAlertController {
//        
//        switch result {
//        case .success(let receipt):
//            print("Verify receipt Success: \(receipt)")
//            return alertWithTitle("Receipt verified", message: "Receipt verified remotely")
//        case .error(let error):
//            print("Verify receipt Failed: \(error)")
//            switch error {
//            case .noReceiptData:
//                return alertWithTitle("Receipt verification", message: "No receipt data. Try again.")
//            case .networkError(let error):
//                return alertWithTitle("Receipt verification", message: "Network error while verifying receipt: \(error)")
//            default:
//                return alertWithTitle("Receipt verification", message: "Receipt verification failed: \(error)")
//            }
//        }
//    }
//    
//    func alertForVerifySubscription(_ result: VerifySubscriptionResult) -> UIAlertController {
//        
//        switch result {
//        case .purchased(let expiryDate):
//            print("Product is valid until \(expiryDate)")
//            return alertWithTitle("Product is purchased", message: "Product is valid until \(expiryDate)")
//        case .expired(let expiryDate):
//            print("Product is expired since \(expiryDate)")
//            return alertWithTitle("Product expired", message: "Product is expired since \(expiryDate)")
//        case .notPurchased:
//            print("This product has never been purchased")
//            return alertWithTitle("Not purchased", message: "This product has never been purchased")
//        }
//    }
//    
//    func alertForVerifyPurchase(_ result: VerifyPurchaseResult) -> UIAlertController {
//        
//        switch result {
//        case .purchased:
//            print("Product is purchased")
//            return alertWithTitle("Product is purchased", message: "Product will not expire")
//        case .notPurchased:
//            print("This product has never been purchased")
//            return alertWithTitle("Not purchased", message: "This product has never been purchased")
//        }
//    }
}

