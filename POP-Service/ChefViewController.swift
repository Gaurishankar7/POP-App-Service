//
//  ChefViewController.swift
//  POP-Service
//
//  Created by Parvez Shaikh on 02/04/19.
//  Copyright © 2019 Parvez Shaikh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChefViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tblChefDetail: UITableView!
    private let cellReuseIdentifier: String = "cell"
     var arrRes = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblChefDetail.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblChefDetail.dataSource = (self as! UITableViewDataSource)
        
        Alamofire.request(GVBaseURL + "chef/selectchefbyid/101" ).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
                
                if let resData = swiftyJsonVar.arrayObject{
                    self.arrRes = resData as! [[String:AnyObject]]
                    print("data is as follow \(self.arrRes) \(self.arrRes.count)")
                }
                if self.arrRes.count>0{
                    self.tblChefDetail.reloadData()
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        var dict = arrRes[indexPath.row]
        
        let imgMenus = UIImageView(frame: CGRect(x: 0, y: 10, width: 80, height: 80) )
        var imageUrlString = dict["chefImage"]as! String
        imageUrlString = GVImageBaseURL + imageUrlString
        let imageUrl:URL = URL(string: imageUrlString)!
        
        imgMenus.image = UIImage(named: "loader.png")
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                imgMenus.image = image
                //                        imgMenus.contentMode = UIView.ContentMode.scaleAspectFit
            }
        }
        cell.addSubview(imgMenus)
        
        let lblName = UILabel(frame: CGRect(x: 100, y: 10, width: UIScreen.main.bounds.width-120, height: 30))
        lblName.text = (dict["chefName"] as! String)
        cell.addSubview(lblName)
        
        let lblGender = UILabel(frame: CGRect(x: 100, y: 40, width: 80, height: 30))
        lblGender.text = (dict["chefGender"] as! String)
        cell.addSubview(lblGender)
        
        let lblMNo = UILabel(frame: CGRect(x: 180, y: 40, width: 150, height: 30))
        lblMNo.text = (dict["chefMobile"] as! String)
        cell.addSubview(lblMNo)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            var dict = self.arrRes[indexPath.row]
            
            Alamofire.request(GVBaseURL + "chef/deletechef/\(dict["chefId"]!)", method: .delete ).responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    print(swiftyJsonVar)
                        self.arrRes.remove(at: indexPath.row)
                        self.tblChefDetail.reloadData()
                }
            }
            
        }
        
        let share = UITableViewRowAction(style: .normal, title: "edit") { (action, indexPath) in
            // share item at indexPath
        }
        
        share.backgroundColor = UIColor.blue
        
        return [delete, share]
    }

    
    
    
    @IBAction func btnAddChefPressed(_ sender: Any) {
        
        
    }
    
}
