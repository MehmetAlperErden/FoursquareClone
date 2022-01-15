//
//  PlacesVc.swift
//  FoursquareClone
//
//  Created by Alper Erden on 24.12.2021.
//

import UIKit
import Parse
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedPlaceId = ""

class PlacesVc: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell()
         cell.textLabel?.text = placeNameArray[indexPath.row]
         return cell
     }
  
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return placeNameArray.count
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          //
          selectedPlaceId = placeIdArray[indexPath.row]
          self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
      }
    func getDataFromParse() {
           
           let query = PFQuery(className: "Places")
           query.findObjectsInBackground { (objects, error) in
               if error != nil {
                   self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
               } else {
                   if objects != nil {
                       
                       self.placeIdArray.removeAll(keepingCapacity: false)
                       self.placeNameArray.removeAll(keepingCapacity: false)
                       
                       for object in objects! {
                           if let placeName = object.object(forKey: "name") as? String {
                               if let placeId = object.objectId {
                                   self.placeNameArray.append(placeName)
                                   self..append(placeId)
                               }

                           }
                       }
                       
                       self.tableView.reloadData()
                   }
               }
           }
           
       }
    func makeAlert(titleInput: String, messageInput: String) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
           let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
       }
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
            }
    
    @objc func addButtonClicked(){
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetailsVC" {
                let destinationVC = segue.destination as! DetailsVC
                destinationVC.chosenPlaceId = selectedPlaceId
            }
        }
    
    @objc func logoutButtonClicked(){
        
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
            }else{
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
                
            }
        
    }

    }
    
}
