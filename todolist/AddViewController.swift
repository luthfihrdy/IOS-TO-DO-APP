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
    
    
    
    @IBAction func createAct(_ sender: Any) {
        
        if(titleField.text != "" || subTitleField.text != ""){
            var newArrayTitle = [String]()
            var newArraySubTitle = [String]()
            
            let defaults = UserDefaults.standard
            var titleValue = titleField.text ?? ""
            var subTitleValue = subTitleField.text ?? ""
            
            var titleNamesArray = defaults.array(forKey: "titleNames") as? [String] ?? [String]()
            var subTitleNamesArray = defaults.array(forKey: "subTitleNames") as? [String] ?? [String]()
            let savedTitleVal = titleValue
            let savedSubTitleVal = subTitleValue
            newArrayTitle = titleNamesArray
            newArrayTitle.append(savedTitleVal)
            defaults.set(newArrayTitle, forKey: "titleNames")
            
            newArraySubTitle = subTitleNamesArray
            newArraySubTitle.append(savedSubTitleVal)
            defaults.set(newArraySubTitle, forKey: "subTitleNames")
            
            print(newArrayTitle)
            
            defaults.synchronize()
            
            let alertController = UIAlertController(title: "Alert", message: "Button clicked!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                let VC =  UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ViewController")
                self.navigationController?.pushViewController(VC, animated: true)
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            
            print(" \(newArrayTitle) , \(newArraySubTitle)")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }else {
            let alert = UIAlertController(title: "Warning", message: "Please Insert Data", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
//        self.performSegue(withIdentifier: "unwindToViewController", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
