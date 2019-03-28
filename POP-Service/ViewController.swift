//
//  ViewController.swift
//  POP-Service
//
//  Created by Parvez Shaikh on 27/03/19.
//  Copyright © 2019 Parvez Shaikh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var txtUserID: UITextField!
    
    @IBOutlet weak var txtPassWord: UITextField!
    
     var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
    }

    
    @IBAction func btnLoginPress(_ sender: Any) {
        
       
        
        if (txtUserID.text?.count)! > 3 && (txtPassWord.text?.count)! > 3 {
            
            
                Alamofire.request(GVBaseURL + "ServiceUser/checkuser/\(txtUserID.text!)/\(txtPassWord.text!)/aaasss" ).responseJSON { (responseData) -> Void in
                    if((responseData.result.value) != nil) {
                        let swiftyJsonVar = JSON(responseData.result.value!)
                        print(swiftyJsonVar)
                        
                        if let tmp = swiftyJsonVar["restaurantId"].string {
                            UserDefaults.standard.set(tmp, forKey: "restId")
                            UserDefaults.standard.set(true, forKey: "userlogin")
                            restIDofRest = Int(tmp)!
                            print("\(restIDofRest)")
                            
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                            self.navigationController?.pushViewController(vc!, animated: true)
                        }
                        
                        
                    }
                }
            
          }
        
        }
       
    
}

