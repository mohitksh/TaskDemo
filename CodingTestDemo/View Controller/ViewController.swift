//
//  ViewController.swift
//  CodingTestDemo
//
//  Created by Mohit Kumar on 07/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtCityName: UITextField!
    @IBOutlet weak var tableViewCityName: UITableView!
    
    
    var arrCityList = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewCityName.dataSource = self
        tableViewCityName.delegate = self
        tableViewCityName.tableFooterView = UIView()
    }
    
    //MARK:- BUTTON ADD LOCATION ACTION
    @IBAction func btnAddCityTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if txtCityName.text! == "" {
            let alert = UIAlertController(title: "", message: "Please enter city name", preferredStyle: .alert)
            let obButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(obButton)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            self.arrCityList.append(txtCityName.text!.lowercased())
            let sortedNames = arrCityList.sorted()
            self.txtCityName.text = ""
            self.arrCityList = sortedNames
            self.tableViewCityName.reloadData()
        }
    }
}

