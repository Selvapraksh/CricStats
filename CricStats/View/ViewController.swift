
import UIKit
import Network

class ViewController: UIViewController {

    
    @IBOutlet weak var progressV: UIActivityIndicatorView!
    
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var matchSort: UIBarButtonItem!
    
    
    let vModel = MatchViewModel()
    
    var matchList: [MatchDetails] = []
    var searchedData = [MatchDetails]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tbl.dataSource = self
        tbl.delegate = self
        mySearchBar.delegate = self
        
        print(NSHomeDirectory())
        tbl.backgroundColor = .clear
        
        filterBy()
        
    }
    
    
    
    var filteredMatchList : [MatchDetails] = []
    

    
    func filterBy() {
        
        let allformat = UIAction(title: "ALL"){
            _ in
            self.filteredMatchList = self.matchList
            self.tbl.reloadData()
        }

        let t20format = UIAction(title: "T20") { _ in
           
            self.filteredMatchList = self.matchList.filter { match in
                match.matchType == "t20"
                
            }
            self.tbl.reloadData()
        }

        let odiformat = UIAction(title: "ODI") { _ in
            self.filteredMatchList = self.matchList.filter { match in
                match.matchType == "odi"
            }
            self.tbl.reloadData()
        }

        let testformat = UIAction(title: "Tests") { _ in
            self.filteredMatchList = self.matchList.filter { match in
                match.matchType == "test"
            }
            self.tbl.reloadData()
        }
        let filter = UIMenu(title: "Filter By:",children: [allformat,t20format,odiformat,testformat])

            matchSort.menu = filter


        }
    
    override func viewWillAppear(_ animated: Bool) {
        if !vModel.isConnected{
            
            self.progressV.isHidden = false
            progressV.startAnimating()
            showAlert(title: "Network Error", msg: "Please connect to the internet")
            tbl.isHidden = true
            let settingUrl = UIApplication.openSettingsURLString
            
            UIApplication.shared.open(URL(string: settingUrl)!)
        }
        else {
            tbl.isHidden = false
            vModel.getMatches { matchResult in
                
                self.filteredMatchList = matchResult
                self.matchList = matchResult
                
                DispatchQueue.main.sync {
                    self.progressV.stopAnimating()
                    self.progressV.isHidden = true
                    self.searchedData = self.matchList
                    self.tbl.reloadData()
                }
            }
        }
            
    }

        func showAlert(title: String, msg: String ){
            let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertVC.addAction(okAction)
    
            present (alertVC, animated: true)
        }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        if searching{

                return searchedData.count

        }

        else{
            
            return filteredMatchList.count
            
        }
        return filteredMatchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchCell
        
        let match = filteredMatchList[indexPath.row]
        
        if searching{
            cell.nameL.text = searchedData[indexPath.row].name
            cell.matchL.text = searchedData[indexPath.row].matchType?.uppercased()
            cell.statusL.text = searchedData[indexPath.row].status
            cell.dateL.text = "🗓️ \(searchedData[indexPath.row].date)"
            
            if String(searchedData[indexPath.row].matchStarted) == "true" && String(searchedData[indexPath.row].matchEnded) == "true"{
                cell.colorL.text = "⏪ Previous match"
                cell.colorL.textColor = .yellow
            }
            if String(searchedData[indexPath.row].matchStarted) == "true" && String(searchedData[indexPath.row].matchEnded) == "false"{
                cell.colorL.text = "🟢 Live"
                cell.colorL.textColor = .green
            }
            if String(searchedData[indexPath.row].matchStarted) == "false" && String(searchedData[indexPath.row].matchEnded) == "false"{
                cell.colorL.text = "⏭️ Upcoming match"
                cell.colorL.textColor = .red
            }

        }

        else {
            cell.nameL.text = "\(match.name)"
            cell.matchL.text = "\(match.matchType?.uppercased() ?? "")"
            cell.statusL.text = "\(match.status)"
            cell.dateL.text = "🗓️ \(match.date)"
            
            if String(match.matchStarted) == "true" && String(match.matchEnded) == "true"{
                cell.colorL.text = "⏪ Previous match"
                cell.colorL.textColor = .yellow
            }
            if String(match.matchStarted) == "true" && String(match.matchEnded) == "false"{
                cell.colorL.text = "🟢 Live"
                cell.colorL.textColor = .green
            }
            if String(match.matchStarted) == "false" && String(match.matchEnded) == "false"{
                cell.colorL.text = "⏭️ Upcoming match"
                cell.colorL.textColor = .red
            }
        }

        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMatch1 = filteredMatchList[indexPath.row]
        let selectedMatch2 = searchedData[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as! MatchDetailVC
        
        if searching{
            vc.match = selectedMatch2
        }
        else{
            vc.match = selectedMatch1
            
        }
        show(vc, sender: self)
      
    }
}

extension ViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchedData = matchList.filter{ $0.name.lowercased().prefix(searchText.count) == searchText.lowercased()}

        searching = true

        tbl.reloadData()

    }

}

