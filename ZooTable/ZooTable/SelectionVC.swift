//
//  SelectionVC.swift
//  ZooTable
//
//  Created by R, Selvaprakash (Contractor) on 03/04/23.
//

import UIKit

class SelectionVC: UIViewController {

    
    
    @IBOutlet var list: UILabel!
    
    @IBOutlet var tableV: UITableView!
    
    var type = ""
    
    var ListofAnimals : [Animals] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        populateData()
        
        tableV.dataSource = self
        tableV.delegate = self
        
        list.text = "\(type)"
        
    }
    
    func populateData(){
        
        switch type {
        case "Domestic Animals" :
            
            ListofAnimals.append(Animals(name: "Dog", population: 75.5, NoOfLegs: 4, imageName: "dog.jpeg"))
            ListofAnimals.append(Animals(name: "Cat", population: 50.5, NoOfLegs: 4, imageName: "cat"))
            ListofAnimals.append(Animals(name: "Goat", population: 60.5, NoOfLegs: 4, imageName: "goat"))
            ListofAnimals.append(Animals(name: "Pig", population: 35.5, NoOfLegs: 4, imageName: "pig"))
            ListofAnimals.append(Animals(name: "Cow", population: 85.5, NoOfLegs: 4, imageName: "cow"))
            
            
        default:
            
            ListofAnimals.append(Animals(name: "Lion", population: 39.5, NoOfLegs: 4, imageName: "lion"))
            ListofAnimals.append(Animals(name: "Elephant", population: 50.5, NoOfLegs: 4, imageName: "elephant"))
            ListofAnimals.append(Animals(name: "Tiger", population: 60.5, NoOfLegs: 4, imageName: "tiger"))
            ListofAnimals.append(Animals(name: "Panda", population: 35.5, NoOfLegs: 4, imageName: "panda"))
            ListofAnimals.append(Animals(name: "Monkey", population: 85.5, NoOfLegs: 4, imageName: "monkey"))
            
            
        }
        
    }
}
    
extension SelectionVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListofAnimals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1. get cell reference
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell",
                                                 for: indexPath) as! AnimalCell
        
        let anm = ListofAnimals[indexPath.row]
        
//        cell.nameL.text = anm.name
//        cell.popL.text = "\(anm.population)"
//        cell.legL.text = "\(anm.NoOfLegs)"
//        cell.img.image = UIImage(named: anm.imageName)
        
        
        //2. bind data
        
        return cell
    }
}
        
    extension SelectionVC: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            print("Selected row :\(indexPath.row)")
            
            let std = ListofAnimals[indexPath.row]
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "finalVC") as! lastVC
            
            vc.selectedAnim = std
            
            show(vc, sender: self)
            
        }
        
        
    }

