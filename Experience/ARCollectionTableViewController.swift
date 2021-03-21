//
//  ARCollectionTableViewController.swift
//  Experience
//
//  Created by Ashutosh Mane on 18.03.2021.
//  Copyright © 2021 Ashutosh Mane. All rights reserved.
//

import UIKit

class ARCollectionViewController: UIViewController {

    @IBOutlet var houseTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in view did load of ARCV")
        self.houseTableView.delegate=self
        self.houseTableView.dataSource=self
        
    }

    
   
}


extension ARCollectionViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.houseTableView.dequeueReusableCell(withIdentifier: "AR_Scene_Cell", for: indexPath) as! ARSceneCell
        
        cell.ARSceneImage.image=UIImage(named: "sample-Image")
        cell.ARSceneTitle.text="Hello-house"
        
        return cell
    }
    
}
 

class ARSceneCell:UITableViewCell{
   
    @IBOutlet var ARSceneImage: UIImageView!
    @IBOutlet var ARSceneTitle: UILabel!
}
