//
//  AddPlacesVC.swift
//  FoursquareClone
//
//  Created by Alper Erden on 27.12.2021.
//

import UIKit

class AddPlacesVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var atmosphereText: UITextField!
    
    @IBOutlet weak var placeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if nameText.text != "" && typeText.text != "" && atmosphereText.text != "" {
                    if let chosenImage = placeImageView.image {
        let placemodel = PlaceModel.sharedInstance
        placemodel.placeName = nameText.text!
        placemodel.placeType = typeText.text!
        placemodel.placeAtmosphere = atmosphereText.text!
                        
        performSegue(withIdentifier: "toMapVC", sender: nil)
        } else {
        let alert = UIAlertController(title: "Error", message: "Place Name/Type/Atmosphere??", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
            }
        
        }
    }
    @objc func chooseImage (){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
   
}
