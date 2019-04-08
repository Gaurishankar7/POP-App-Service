//
//  AddEditChefViewController.swift
//  POP-Service
//
//  Created by Parvez Shaikh on 02/04/19.
//  Copyright © 2019 Parvez Shaikh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddEditChefViewController: UIViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imgChef: UIImageView!
   var imagePicker = UIImagePickerController()
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtPhoneNo: UITextField!
    @IBOutlet weak var segmntGender: UISegmentedControl!

    var imgFromCamera: UIImage? = nil
    
    var gender = "Male"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgChef.isUserInteractionEnabled = true
        imgChef.addGestureRecognizer(tapGestureRecognizer)
        
       imagePicker.delegate = self
        
        txtName.delegate = self
        txtPhoneNo.delegate = self
        
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    @objc func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        imgChef.image = image
        imgFromCamera = image
        imgChef.clipsToBounds = true
        print(image)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == txtName{
//            txtPhoneNo.resignFirstResponder()
//        }
//        else{
        self.view.endEditing(true)
//        }
        return false
    }
    
    @IBAction func segmentChangeGender(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            print("first segement clicked")
            gender = "Male"
        case 1:
            print("second segment clicked")
            gender = "Female"
        default:
            break;
        }
    }
    

    @IBAction func btnSubmitPress(_ sender: Any) {
        
        var parameters : [String:Any] = [:]
        parameters["restaurantId"] = 101
        parameters["chefName"] = txtName.text
        parameters["chefMobile"] = txtPhoneNo.text
        parameters["chefGender"] = gender
        
        let url = GVBaseURL + "chef/addchef"
        print(url)
        
//        let URL = "http://yourserviceurl/"
//        let image = UIImage(named: "qr-code.png")
        let image = imgFromCamera
        
        requestWith(endUrl: url, imageData: image?.pngData(), parameters: parameters)

            
            
    }
    
    func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let url = GVBaseURL + "chef/addchef" /* your API url */
//        let url = "http://192.168.1.164:8080/api/chef/addchef"
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "chefImage", fileName: "image.jpg", mimeType: "image/png")
                print(multipartFormData)
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                     print("Succesfully uploaded")
//                    print(response.success.chefId)
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }
    
    
    
    

}
