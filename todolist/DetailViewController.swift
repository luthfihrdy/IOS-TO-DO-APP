//
//  DetailViewController.swift
//  todolist
//
//  Created by M Luthfi on 17/06/22.
//

import Foundation

import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var subTitleField: UITextField!
    @IBOutlet weak var notesField: UITextView!
    
    
    
    struct detailData {
        static var titleData = ""
        static var subTitleData = ""
        static var notesData = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.text = detailData.titleData
//        subTitleField.text = subTitleData
//        notesField.text = notesData
        
        //var detailData = ""
        
    }
    
}
