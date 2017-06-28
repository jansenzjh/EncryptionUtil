//
//  Information.swift
//  EncryptionUtil
//
//  Created by Jansen on 6/16/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import Foundation
import RealmSwift

class Information: Object {

    dynamic var Guid: String = UUID().uuidString
    dynamic var TypeId = ""
    dynamic var Text = ""
    dynamic var Contact = ""
    dynamic var FullName = ""
    dynamic var Company = ""
    dynamic var Mobile = ""
    dynamic var Home = ""
    dynamic var Work = ""
    dynamic var Email = ""
    dynamic var Title = ""
    dynamic var UserName = ""
    dynamic var Password = ""
    dynamic var Description = ""
    dynamic var StartDate = Date()
    dynamic var EndDate = Date()
    dynamic var Website = ""
    dynamic var Notes = ""
    
    func GetAllInformations(isActiveOnly: Bool) -> [Information]{
        
        let realm = try! Realm()
        if !isActiveOnly{
            let list = realm.objects(Information.self).sorted(byKeyPath: "EndDate", ascending: true)
            let infoArr = Array(list)
            return infoArr
        }else{
            let list = realm.objects(Information.self).filter("Status = %@", "Open").sorted(byKeyPath: "EndDate", ascending: true)
            let infoArr = Array(list)
            return infoArr
        }
    }
    
    
    
    func GetInformation(guid: String) -> Information{
        let obj = try! Realm().objects(Information.self).filter("Guid = %@", guid).first
        if (obj != nil){
            return (obj!)
        }else{
            return Information()
        }
    }
    
    func GetInformationDescByGuid(guid: String) -> String{
        return GetInformation(guid: guid).Description
    }
    
    func GetInformationGuidByDesc(desc: String) -> String{
        let obj = try! Realm().objects(Information.self).filter("Description = %@", desc).first
        if (obj != nil){
            return (obj?.Guid)!
        }else{
            return ""
        }
    }
    
    
    
    
    func Save(){
        let realm = try! Realm()
        
        let dtls = realm.objects(Information.self).filter("Guid = %@", self.Guid)
        if dtls.count > 0 {
            //existing history
            let theDtl = realm.objects(Information.self).filter("Guid = %@", self.Guid).first
            try! realm.write {
                
                theDtl?.Guid = self.Guid
                theDtl?.TypeId = self.TypeId
                theDtl?.Text = self.Text
                theDtl?.Contact = self.Contact
                theDtl?.FullName = self.FullName
                theDtl?.Company = self.Company
                theDtl?.Mobile = self.Mobile
                theDtl?.Home = self.Home
                theDtl?.Work = self.Work
                theDtl?.Email = self.Email
                theDtl?.Title = self.Title
                theDtl?.UserName = self.UserName
                theDtl?.Password = self.Password
                theDtl?.Description = self.Description
                theDtl?.StartDate = self.StartDate
                theDtl?.EndDate = self.EndDate
                theDtl?.Website = self.Website
                theDtl?.Notes = self.Notes
            }
        }else{
            //insert a new one
            try! realm.write {
                let theDtl = Information()
                
                theDtl.Guid = self.Guid
                theDtl.TypeId = self.TypeId
                theDtl.Text = self.Text
                theDtl.Contact = self.Contact
                theDtl.FullName = self.FullName
                theDtl.Company = self.Company
                theDtl.Mobile = self.Mobile
                theDtl.Home = self.Home
                theDtl.Work = self.Work
                theDtl.Email = self.Email
                theDtl.Title = self.Title
                theDtl.UserName = self.UserName
                theDtl.Password = self.Password
                theDtl.Description = self.Description
                theDtl.StartDate = self.StartDate
                theDtl.EndDate = self.EndDate
                theDtl.Website = self.Website
                theDtl.Notes = self.Notes
                
                realm.add(theDtl)
            }
        }
    }
    
    func Update(){
        let realm = try! Realm()
        
        let dtls = realm.objects(Information.self).filter("Guid = %@", (self.Guid))
        if dtls.count > 0 {
            //existing history
            let theDtl = realm.objects(Information.self).filter("Guid = %@", (self.Guid)).first
            try! realm.write {
                
                theDtl!.Guid = self.Guid
                theDtl!.TypeId = self.TypeId
                theDtl!.Text = self.Text
                theDtl!.Contact = self.Contact
                theDtl!.FullName = self.FullName
                theDtl!.Company = self.Company
                theDtl!.Mobile = self.Mobile
                theDtl!.Home = self.Home
                theDtl!.Work = self.Work
                theDtl!.Email = self.Email
                theDtl!.Title = self.Title
                theDtl!.UserName = self.UserName
                theDtl!.Password = self.Password
                theDtl!.Description = self.Description
                theDtl!.StartDate = self.StartDate
                theDtl!.EndDate = self.EndDate
                theDtl!.Website = self.Website
                theDtl!.Notes = self.Notes
                
            }
            
        }
    }
    
    func Delete(guid: String){
        let realm = try! Realm()
        let obj = realm.objects(Information.self).filter("Guid = %@", guid).first
        if (obj != nil){
            try! realm.write{
                realm.delete(obj!)
            }
            
        }
    }
    func Count() -> Int{
        let realm = try! Realm()
        
        return realm.objects(Information.self).count
    }

}
