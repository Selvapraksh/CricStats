//
//  lastVC.swift
//  ZooTable
//
//  Created by R, Selvaprakash (Contractor) on 04/04/23.
//

import UIKit

class lastVC: UIViewController {
    
    @IBOutlet var legS: UILabel!
    @IBOutlet var popC: UILabel!
    @IBOutlet var nameA: UILabel!
    @IBOutlet var imgV: UIImageView!
    
    var selectedAnim: Animals?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameA.text = selectedAnim?.name
        popC.text = "\(selectedAnim?.population ?? 0)"
        legS.text = "\(selectedAnim?.NoOfLegs ?? 1)"
        // Do any additional setup after loading the view.
        
        imgV.image = UIImage (named: selectedAnim?.imageName ?? "a")
        
        
        
    }
    
    

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
