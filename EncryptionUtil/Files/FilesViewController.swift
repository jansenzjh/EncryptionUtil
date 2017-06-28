//
//  FilesViewController.swift
//  EncryptionUtil
//
//  Created by Jansen on 6/18/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import UIKit

class FilesViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.btnOpenFilesBrowser(UIBarButtonItem())
        
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("EncryptionUtil")
        // Do any additional setup after loading the view.
        //let fileBrowser = FileBrowser(initialPath: dataPath, allowEditing: true)
        
        //let fileExplorer = FileExplorerViewController()
        let fileExplorer = FileExplorerViewController(directoryURL: dataPath, providers: [])
        
        
        self.addChildViewController(fileExplorer)
        self.view.addSubview(fileExplorer.view)
        fileExplorer.didMove(toParentViewController: self)
        
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

}
