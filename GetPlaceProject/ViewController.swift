//
//  ViewController.swift
//  GetPlaceProject
//
//  Created by admin on 3/19/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker


class ViewController: UIViewController, GMSPlacePickerViewControllerDelegate {
   
    @IBOutlet var googleMapView: GMSMapView!
    @IBOutlet weak var nameLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // The code snippet below shows how to create and display a GMSPlacePickerViewController.
    @IBAction func pickPlace(_ sender: UIButton) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("Place name \(String(describing: place.name))")
        print("Place address \(String(describing: place.formattedAddress))")
        print("Place attributions \(String(describing: place.attributions))")
        nameLabel.text = place.formattedAddress
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }

}

