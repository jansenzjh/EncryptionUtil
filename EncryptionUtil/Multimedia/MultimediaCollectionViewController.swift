//
//  MultimediaCollectionViewController.swift
//  EncryptionUtil
//
//  Created by Jansen on 6/19/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import ImagePicker
import FileKit

private let reuseIdentifier = "mediaCollectCell"

class MultimediaCollectionViewController: UICollectionViewController , ImagePickerDelegate, SKPhotoBrowserDelegate{

    @IBAction func btnMediaAdd(_ sender: UIBarButtonItem) {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    var mediaURLList: [URL] = [URL]()
    
    //var mediaList: [UIImage] = [UIImage]()
    var reviewMediaList = [SKPhoto]()
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAppFolderIfNeed()
        loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func loadData() {
        
        mediaURLList = [URL]()
        //mediaList = [UIImage]()
        reviewMediaList = [SKPhoto]()
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("EncryptionUtil")
        
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: dataPath, includingPropertiesForKeys: nil, options: [])
            //print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            let imgFiles = directoryContents.filter{ $0.pathExtension == "jpg" }
            
            mediaURLList = imgFiles
            
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return mediaURLList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MediaCollectionViewCell
        
        //let img = mediaList[indexPath.row]
        
        DispatchQueue.global(qos: .userInitiated).async {
            let imgg = UIImage(url: self.mediaURLList[indexPath.row])//?.resized(toWidth: 0.1)
            
            
            DispatchQueue.main.async {
                cell.imageView.image = imgg
                
            }
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MediaCollectionViewCell
        if reviewMediaList.count == 0{
            for url in self.mediaURLList{
                //let img = UIImage(url: url)
                reviewMediaList.append(SKPhoto.photoWithImageURL(url.absoluteString))
            }
            
        }
        let originImage = UIImage(url: self.mediaURLList[indexPath.row])
        SKPhotoBrowserOptions.displayDeleteButton = true
        let browser = SKPhotoBrowser(originImage: originImage! , photos: reviewMediaList, animatedFromView: cell)
        browser.delegate = self
        browser.initializePageIndex(indexPath.row)
        present(browser, animated: true, completion: {})
    }

    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func createAppFolderIfNeed(){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("EncryptionUtil")
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
        
    }
    
    
    // MARK: Image Picker Delegate
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("EncryptionUtil")
        for img in images {
            
            if let data = UIImageJPEGRepresentation(img, 0.5) {
                let filename = dataPath.appendingPathComponent(Date().toString(dateFormat: "yy_MM_dd_hhmmss_") + String().random(length: 4) + ".jpg")
                try? data.write(to: filename)
            }
            
        }
        loadData()
        self.collectionView?.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController){
        
    }
}

extension MultimediaCollectionViewController {
    func didDismissAtPageIndex(_ index: Int) {
    }
    
    func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
    }
    
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        try! FileManager.default.removeItem(at: mediaURLList[index])
        reload()
        loadData()
        self.collectionView?.reloadData()
    }
    
    
}
