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


class ViewController: UIViewController, GMSMapViewDelegate, UISearchBarDelegate,LocateOnTheMap {
//    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
//        for prediction in predictions {
//            
//            if let prediction = prediction as GMSAutocompletePrediction?{
//                self.resultsArray.append(prediction.attributedFullText.string)
//            }
//        }
//        self.searchResultController.reloadDataWithArray(self.resultsArray)
//        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
//        print(resultsArray)
//    }
//    
//    func didFailAutocompleteWithError(_ error: Error) {
//    }
    
   
  
//    @IBAction func pickPlace(_ sender: UIButton) {
//        let config = GMSPlacePickerConfig(viewport: nil)
//        let placePicker = GMSPlacePickerViewController(config: config)
//
//        present(placePicker, animated: true, completion: nil)
//
//    }
    
    @IBOutlet var googleMapsContainer: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
//    internal let kPlacesAPIKey = "AIzaSyBEKYyw2_ztMDaB8G-ZtDWr73po1eQwQ-E"
//    internal let kMapsAPIKey = "AIzaSyBEKYyw2_ztMDaB8G-ZtDWr73po1eQwQ-E"
  
    var gogleMapsView: GMSMapView?
    var placesClient: GMSPlacesClient!
    var infoMarker = GMSMarker()
    var placePicker: GMSPlacePickerConfig?

//    var gmsFetcher: GMSAutocompleteFetcher!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gogleMapsView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: 21.053993, longitude: 105.734564, zoom: 15.0)
        gogleMapsView?.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 21.053993, longitude: 105.734564)
        marker.title = "Đại Học Công Nghiệp Hà Nội"
        marker.snippet = "Hà Nội"
        marker.map = gogleMapsView
        gogleMapsView?.delegate = self
        
    
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.gogleMapsView = GMSMapView(frame: self.googleMapsContainer.frame)
        self.view.addSubview(self.gogleMapsView!)
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
       
//        gmsFetcher = GMSAutocompleteFetcher()
//        gmsFetcher.delegate = self as GMSAutocompleteFetcherDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        let picker = "\(name)"
        nameLabel.text = picker
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15.0)
        gogleMapsView?.animate(to: camera)
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = gogleMapsView
        gogleMapsView?.selectedMarker = infoMarker
       
    }
    
//    // To receive the results from the place picker 'self' will need to conform to
//    // GMSPlacePickerViewControllerDelegate and implement this code.
//    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
//        // Dismiss the place picker, as it cannot dismiss itself.
//        viewController.dismiss(animated: true, completion: nil)
//
//        print("Place name \(String(describing: place.name))")
//        print("Place address \(String(describing: place.formattedAddress))")
//        print("Place attributions \(String(describing: place.attributions))")
//    }
//
//    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
//        // Dismiss the place picker, as it cannot dismiss itself.
//        viewController.dismiss(animated: true, completion: nil)
//
//        print("No place selected")
//    }
    
    @IBAction func searchWithAddress(_ sender: Any) {
        
        let searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.searchBar.delegate = self
        
        
        
        self.present(searchController, animated:true, completion: nil)
        
    }
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        DispatchQueue.main.async { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            self.gogleMapsView?.camera = camera
            
            marker.title = "Address : \(title)"
            marker.map = self.gogleMapsView
            
        }
    }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let placeClient = GMSPlacesClient()
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error: Error?) -> Void in
                self.resultsArray.removeAll()
            if results == nil {
                return
            }
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    self.resultsArray.append(result.attributedFullText.string)
                }
            }
            self.searchResultController.reloadDataWithArray(self.resultsArray)
        }
        
//        self.resultsArray.removeAll()
//        gmsFetcher?.sourceTextHasChanged(searchText)
           self.searchResultController.reloadDataWithArray(self.resultsArray)
    }
//
//    func didUpdateAutocompletePredictionsForTableDataSource(tableDataSource: GMSAutocompleteTableDataSource) {
//        // Turn the network activity indicator off.
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//        // Reload table data.
//        searchDisplayController?.searchResultsTableView.reloadData()
//    }
//
//    func didRequestAutocompletePredictionsForTableDataSource(tableDataSource: GMSAutocompleteTableDataSource) {
//        // Turn the network activity indicator on.
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        // Reload table data.
//        searchDisplayController?.searchResultsTableView.reloadData()
//    }
////

}



