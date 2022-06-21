//
//  ViewController.swift
//  todolist
//
//  Created by M Luthfi on 16/06/22.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var defaults = UserDefaults.standard
    var taskList:[task] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        cell?.titleLabel.text = taskList[indexPath.row].title
        cell?.subTitleLabel.text = taskList[indexPath.row].subtitle
        cell?.notesLabel.text = taskList[indexPath.row].notes
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                
                self.taskList.remove(at: indexPath.row)
                let encoder = PropertyListEncoder()
                          
                  if let encoded = try? encoder.encode(taskList) {
                      defaults.set(encoded, forKey: "data")
                     
                  }
                  tableView.reloadData()
                
                //let defaults = UserDefaults.standard
//                titleArr = defaults.array(forKey: "titleNames") as? [String] ?? [String]()
//                subTitleArr = defaults.array(forKey: "subTitleNames") as? [String] ?? [String]()
//                notesArr = defaults.array(forKey: "notesNames") as? [String] ?? [String]()
                
//                titleArr.remove(at: indexPath.row)
//                subTitleArr.remove(at: indexPath.row)
//                notesArr.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
//                defaults.set(titleArr, forKey: "titleNames")
//                defaults.set(subTitleArr, forKey: "subTitleNames")
//                defaults.set(notesArr, forKey: "notesNames")
//                defaults.synchronize()
            }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                // delete the item here
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
    
    //Klik Cell
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(taskList)
        print(indexPath.row)
        
        DetailViewController.detailData.titleData = taskList[indexPath.row].title
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        let detailController = segue.destination as? DetailViewController
//        detailController?.title = taskList[indexPath.row].title
//        detailController?.subTitleData = taskList[indexPath.row].subtitle
//        detailController?.notesData = taskList[indexPath.row].notes
//    }

    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleArr = [String]()
    var subTitleArr = [String]()
    var notesArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedData = defaults.value(forKey: "data") as? Data {
            let loadedData = try? PropertyListDecoder().decode(Array<task>.self, from: savedData)
            taskList = loadedData!
        }
        
        
        // Do any additional setup after loading the view.
        //let defaults = UserDefaults.standard
        tableView.delegate = self
        tableView.dataSource = self
        titleArr = defaults.array(forKey: "titleNames") as? [String] ?? [String]()
        subTitleArr = defaults.array(forKey: "subTitleNames") as? [String] ?? [String]()
        notesArr = defaults.array(forKey: "notesNames") as? [String] ?? [String]()
//        UserDefaults.standard.set("", forKey: "subTitleNames")
//        UserDefaults.standard.set("", forKey: "titleNames")
//        UserDefaults.standard.set("", forKey: "notesNames")
//        
        print(titleArr.count)
        print(subTitleArr.count)
        print(notesArr.count)
        tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        let detailController = segue.destination as? DetailViewController
////        detailController?.detailData = nameField.text ?? ""
//    }


}

