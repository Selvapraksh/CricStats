//
//  ViewController.swift
//  contact2
//
//  Created by R, Selvaprakash (Contractor) on 13/04/23.
//

import UIKit

class viewController: UIViewController {
    
    
    @IBOutlet var tableV: UITableView!
    
    @IBOutlet var searchB: UISearchBar!
    
    var contactArr = ["Aswathy","Anjali","Agnivesh","Aravind","Anbu","Arivu","Alagar","Altaf","Aasik","Balaji","Bhuvaneshwari","Bala","Dinesh","Eshan","Fredrick","Ganesh","Giri","Kosha","Leena","Nirmal","Nivetha","Prathiba","Praveen","Priyanka","Purvi","Rithesh","Selva","Sivaram","Samiksha","Sambhav","Somaja","Thilothini","Yogi "]
    
    var searchContact = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        
        let alertVC = UIAlertController(title: "New Contact",message: nil, preferredStyle: .alert)
        
        alertVC.addTextField(){ tf in
            
            tf.placeholder = "Name"
            
        }
        let addEmpAction = UIAlertAction(title: "Add Contact", style: .default){_ in
            
          //  get; the; data; through; placeholder
            let name = alertVC.textFields?[0].text ?? ""
            
            self.contactArr.append(name)
            

            self.tableV.reloadData()
        }
        alertVC.addAction(addEmpAction)
        present(alertVC, animated: true)
        
    }
    
}
    
extension viewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        if searching {
           return searchContact.count
        }else
        {
            return contactArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1. get cell reference
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
        if searching{
            cell?.textLabel?.text = searchContact[indexPath.row]
        }
        else
        {
            cell?.textLabel?.text = contactArr[indexPath.row]
        }
       
        return cell!
    }
}

extension viewController: UISearchBarDelegate
{
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchContact = contactArr.filter( {$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
       searching = true
       tableV.reloadData()
      print("Contactname\(contactArr)")
    }
   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searching = false
        searchBar.text  = ""
      tableV.reloadData()
    }
}

        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


