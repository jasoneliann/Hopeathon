//
//  DummyTableViewController.swift
//  HopeathonAdmin
//
//  Created by Jason Elian on 05/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import UIKit

class DummyTableViewController: UITableViewController {

    let idDummy : String = "dummyTableViewCell"
    
    var titleA : String? = nil
    
    var dummyImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "DummyTableViewCell", bundle: nil), forCellReuseIdentifier: idDummy)
        guard let unwrappedTitle = titleA else {return}
        title = unwrappedTitle
        navigationItem.backBarButtonItem?.tintColor = UIColor.clear
        navigationItem.backBarButtonItem?.title = ""
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idDummy, for: indexPath) as! DummyTableViewCell
        guard let unwrappedDummy = dummyImage else {return cell}
        cell.imageViewDummy.image = unwrappedDummy
        return cell
    }

}
