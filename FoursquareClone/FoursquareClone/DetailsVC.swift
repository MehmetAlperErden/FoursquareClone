//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Alper Erden on 28.12.2021.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var atmosphereLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var chosenPlaceId = ""
       
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromParse()
        print(chosenPlaceId)

        // Do any additional setup after loading the view.
    }
    
    func getDataFromParse() {
           
           let query = PFQuery(className: "Places")
           query.whereKey("objectId", equalTo: chosenPlaceId)
           query.findObjectsInBackground { (objects, error) in
               if error != nil {
                   
               } else {
                   if objects != nil {
                       if objects!.count > 0 {
                           let chosenPlaceObject = objects![0]
                           
                           // OBJECTS
                           
                           if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                               self.nameLabel.text = placeName
                           }
                           
                           if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                               self.typeLabel.text = placeType
                           }
                           
                           if let placeAtmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                               self.atmosphereLabel.text = placeAtmosphere
                           }
                           
                           if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                               if let placeLatitudeDouble = Double(placeLatitude) {
                                   self.chosenLatitude = placeLatitudeDouble
                               }
                           }
                           
                           if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                               if let placeLongitudeDouble = Double(placeLongitude) {
                                   self.chosenLongitude = placeLongitudeDouble
                               }
                           }
                           
                           if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                               imageData.getDataInBackground { (data, error) in
                                   if error == nil {
                                       if data != nil {
                                       self.imageView.image = UIImage(data: data!)
                                       }
                                   }
                               }
                           }
    
                       }
                    
                   }
                
               }
            
           }
        
    }
    
}

    

                       

