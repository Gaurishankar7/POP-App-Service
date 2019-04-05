//
//  StatusChangeViewController.swift
//  POP-Service
//
//  Created by Parvez Shaikh on 28/03/19.
//  Copyright © 2019 Parvez Shaikh. All rights reserved.
//

import UIKit

class StatusChangeViewController: UIViewController, UITableViewDataSource {
    

    @IBOutlet weak var tblOrderDetails: UITableView!
    //    let cellReuseIdentifier = "cell"
    private let cellReuseIdentifier: String = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

         tblOrderDetails.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblOrderDetails.dataSource = (self as! UITableViewDataSource)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel?.text = "Menu name and quantity"
        return cell
    }
   
    @IBAction func btnInpregressPress(_ sender: Any) {
        
        let viewforchef = UIView(frame: CGRect(x: 40, y: 40, width: UIScreen.main.bounds.width-80, height: UIScreen.main.bounds.height-80))
//        viewforchef.alpha = 0.5
        viewforchef.backgroundColor = UIColor.white
        view.addSubview(viewforchef)
        
        
        
    }
    
}
