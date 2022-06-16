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
        return cell!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        tableView.delegate = self
        tableView.dataSource = self
        titleArr = defaults.array(forKey: "titleNames") as? [String] ?? [String]()
        subTitleArr = defaults.array(forKey: "subTitleNames") as? [String] ?? [String]()
//        UserDefaults.standard.set("", forKey: "subTitleNames")
//        UserDefaults.standard.set("", forKey: "titleNames")
        print(titleArr.count)
        print(subTitleArr.count)
        tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }


}

