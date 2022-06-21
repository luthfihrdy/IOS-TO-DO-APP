//
//  AddViewController.swift
//  todolist
//
//  Created by M Luthfi on 16/06/22.
//

import Foundation

import UIKit


class AddViewController: UIViewController{

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var subTitleField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    
    var dataList:[task] = []
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesField.addConstraint(notesField.heightAnchor.constraint(equalToConstant: 500))
    }
    
    
    @IBAction func createAct(_ sender: Any) {
        
        let titleValue = titleField.text ?? ""
        let subtitleValue = subTitleField.text ?? ""
        let notesValue = notesField.text ?? ""
        
        if(titleField.text == ""){
            let dialogMessage = UIAlertController(title: "Attention", message: "Title is required", preferredStyle: .alert)
            
            let ok = UIAlertAction(title:"OK",style: .default, handler: {(action)-> Void in
                                  print("OK")
                              })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage,animated: true, completion: nil)
        }else if(subTitleField.text == ""){
            let dialogMessage = UIAlertController(title: "Attention", message: "Sub title is required", preferredStyle: .alert)
            
            let ok = UIAlertAction(title:"OK",style: .default, handler: {(action)-> Void in
                                  print("OK")
                              })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage,animated: true, completion: nil)
            //subTitleField.becomeFirstResponder()
        }else {
            if let savedData = defaults.value(forKey: "data") as? Data {
                let loadedData = try? PropertyListDecoder().decode(Array<task>.self, from: savedData)
                dataList = loadedData!
            }
            
            dataList.append(task(title:titleValue, subtitle: subtitleValue, notes: notesValue))
            print(dataList)
            
            let encoder = PropertyListEncoder()
            
            if let encoded = try? encoder.encode(dataList) {
                defaults.set(encoded, forKey: "data")
            }
            
            let alertController = UIAlertController(title: "Alert", message: "Success", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                let VC =  UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ViewController")
                self.navigationController?.pushViewController(VC, animated: true)
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
//
//        if(titleField.text != "" || subTitleField.text != ""){
//            var newArrayTitle = [String]()
//            var newArraySubTitle = [String]()
//            var newArrayNotes = [String]()
//
//            //let defaults = UserDefaults.standard
//            var titleValue = titleField.text ?? ""
//            var subTitleValue = subTitleField.text ?? ""
//            var notesValue = notesField.text ?? ""
//
//            var titleNamesArray = defaults.array(forKey: "titleNames") as? [String] ?? [String]()
//            var subTitleNamesArray = defaults.array(forKey: "subTitleNames") as? [String] ?? [String]()
//            var notesArray = defaults.array(forKey: "notesNames") as? [String] ?? [String]()
//
//            let savedTitleVal = titleValue
//            let savedSubTitleVal = subTitleValue
//            let savedNotesVal = notesValue
//
//            newArrayTitle = titleNamesArray
//            newArrayTitle.append(savedTitleVal)
//            defaults.set(newArrayTitle, forKey: "titleNames")
//
//            newArraySubTitle = subTitleNamesArray
//            newArraySubTitle.append(savedSubTitleVal)
//            defaults.set(newArraySubTitle, forKey: "subTitleNames")
//
//            newArrayNotes = notesArray
//            newArrayNotes.append(savedNotesVal)
//            defaults.set(newArrayNotes, forKey: "notesNames")
//
//            print(newArrayTitle)
//
//            defaults.synchronize()
//
//            let alertController = UIAlertController(title: "Alert", message: "Success", preferredStyle: .alert)
//            let OKAction = UIAlertAction(title: "OK", style: .default) {
//                (action: UIAlertAction!) in
//                // Code in this block will trigger when OK button tapped.
//                let VC =  UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ViewController")
//                self.navigationController?.pushViewController(VC, animated: true)
//            }
//            alertController.addAction(OKAction)
//            self.present(alertController, animated: true, completion: nil)
//
//            print(" \(newArrayTitle) , \(newArraySubTitle) , \(newArrayNotes)")
//
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
//        }else {
//            let alert = UIAlertController(title: "Warning", message: "Data is required", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
//
//
////        self.performSegue(withIdentifier: "unwindToViewController", sender: self)
    }
    
    
    
}
