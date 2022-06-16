//
//  ViewController.swift
//  todolist
//
//  Created by M Luthfi on 16/06/22.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        cell?.titleLabel.text = titleArr[indexPath.item]
        cell?.subTitleLabel.text = subTitleArr[indexPath.item]
        cell?.notesLabel.text = notesArr[indexPath.item]
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
                let defaults = UserDefaults.standard
                titleArr = defaults.array(forKey: "titleNames") as? [String] ?? [String]()
                subTitleArr = defaults.array(forKey: "subTitleNames") as? [String] ?? [String]()
                notesArr = defaults.array(forKey: "notesNames") as? [String] ?? [String]()
                
                titleArr.remove(at: indexPath.row)
                subTitleArr.remove(at: indexPath.row)
                notesArr.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                defaults.set(titleArr, forKey: "titleNames")
                defaults.set(subTitleArr, forKey: "subTitleNames")
                defaults.set(notesArr, forKey: "notesNames")
                defaults.synchronize()
            }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
//    class: FirstViewController {
//        var tableView: UITableView
//
//        present(SecondViewController(), animated: true, completion: nil)
//    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
//    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
//        DispatchQueue.global(qos: .userInitiated).async {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    var titleArr = [String]()
    var subTitleArr = [String]()
    var notesArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
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


}

