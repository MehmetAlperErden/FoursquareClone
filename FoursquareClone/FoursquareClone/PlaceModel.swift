//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Alper Erden on 29.12.2021.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init(){}
    
}
