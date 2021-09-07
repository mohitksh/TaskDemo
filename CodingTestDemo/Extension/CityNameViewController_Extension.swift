//
//  File.swift
//  CodingTestDemo
//
//  Created by Mohit Kumar on 07/09/21.
//

import Foundation
import UIKit
import MapKit


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableListCell") as! CityTableListCell
        cell.lblCityName.text = arrCityList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.selectedCity = arrCityList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
