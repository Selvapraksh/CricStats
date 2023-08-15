//
//  ShownA.swift
//  ZooTable
//
//  Created by R, Selvaprakash (Contractor) on 03/04/23.
//

import UIKit

class ShownA: UIViewController {

    
    @IBOutlet var legL: UILabel!
    @IBOutlet var popL: UILabel!
    @IBOutlet var nameL: UILabel!
    
    
    @IBOutlet var imgL: UIImageView!
    
    
    var selectedAnim: Animals?
    override func viewDidLoad() {
        super.viewDidLoad()

        nameL.text = selectedAnim?.name
        popL.text = "\(selectedAnim?.population ?? 0)"
        legL.text = "\(selectedAnim?.NoOfLegs ?? 1)"
        // Do any additional setup after loading the view.
        
        img.image = UIImage(systemName: "download")
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
