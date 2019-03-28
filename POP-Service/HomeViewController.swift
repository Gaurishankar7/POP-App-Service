//
//  HomeViewController.swift
//  POP-Service
//
//  Created by Parvez Shaikh on 27/03/19.
//  Copyright © 2019 Parvez Shaikh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collView: UICollectionView!
    private let reuseIdentifier = "FirstCell"
    override func viewDidLoad() {
        super.viewDidLoad()

        print("i am here")
        collView.delegate = self
        collView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    //3
    internal func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//        cell.backgroundColor = .black
        // Configure the cell
        return cell
    }
    
    
    @IBAction func btnChangeStatusOress(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StatusChangeViewController")as! StatusChangeViewController
         self.present(vc, animated: true, completion: nil)
    }
    
}
