
import UIKit

class MatchDetailVC: UIViewController {

    @IBOutlet weak var team1L: UILabel!
    
    @IBOutlet weak var team2L: UILabel!
    
    @IBOutlet weak var dateL: UILabel!
    
    @IBOutlet weak var matchtypeL: UILabel!
    
    @IBOutlet weak var venueL: UILabel!
    
    @IBOutlet weak var shortn1L: UILabel!
    
    @IBOutlet weak var shortn2L: UILabel!
    

    
    @IBOutlet weak var inning1L: UILabel!
    
    @IBOutlet weak var inning2L: UILabel!
    
    @IBOutlet weak var run1L: UILabel!
    
    @IBOutlet weak var wic1L: UILabel!
    
    @IBOutlet weak var over1L: UILabel!
    
    @IBOutlet weak var run2L: UILabel!
    
    @IBOutlet weak var wic2L: UILabel!
    
    @IBOutlet weak var over2L: UILabel!
    
    @IBOutlet weak var startedL: UILabel!
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var statusL: UILabel!
    

    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    
    
    var match: MatchDetails?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let match = match {
            
            nameL.text = match.name
            
            if  match.teamInfo.count == 1
            {
                team1L.text = "TEAM ❶ : \(match.teamInfo[0].name ?? "")"
                shortn1L.text = match.teamInfo[0].shortname
                team2L.text = "Not Available"
                shortn2L.text = ""
                
                let imgUrl = match.teamInfo[0].img
                print(imgUrl)
                img1.downloaded(from: imgUrl)
                
            }
            
            else if match.teamInfo.count >=  2            {
                
                team1L.text = "TEAM ❶ : \(match.teamInfo[0].name ?? "")"
                shortn1L.text = match.teamInfo[0].shortname
                team2L.text = "TEAM ❷ : \(match.teamInfo[1].name ?? "")"
                shortn2L.text = match.teamInfo[1].shortname
                
                
                
                let imgUrl1 = match.teamInfo[0].img
                print(imgUrl1)
                img1.downloaded(from: imgUrl1)
                
                
                let imgUrl2 = match.teamInfo[1].img
                print(imgUrl2)
                img2.downloaded(from: imgUrl2)
      
            }
            else {
                team1L.text = "Not Available"
                shortn1L.text = "NA"
                team2L.text = "Not Available"
                shortn2L.text = "NA"
            }
                

            dateL.text = "🗓️    \(match.date)"
            matchtypeL.text = "MATCHTYPE: \(match.matchType?.uppercased() ?? "NIL")"
            venueL.text = "VENUE: \(match.venue)"

            statusL.text = " 📌 \(match.status)"
            
            if String(match.matchStarted) == "true" && String(match.matchEnded) == "true"{
                startedL.text = "MATCH ENDED ✅"
            }
            if String(match.matchStarted) == "true" && String(match.matchEnded) == "false"{
                startedL.text = "Match is going on...🏁"
            }
            if String(match.matchStarted) == "false" && String(match.matchEnded) == "false"{
                startedL.text = "Match not yet started ⏳"
            }
            
            if  match.score.count == 1 {
                inning1L.text = "Innings: \(match.score[0].inning)"
                run1L.text = "Runs: \(Int(match.score[0].r))"
                wic1L.text = "Wickets: \(Int(match.score[0].w))"
                over1L.text = "Overs: \(String(match.score[0].o))"
                inning2L.text = "NA"
                run2L.text = "NA"
                wic2L.text = "NA"
                over2L.text = "NA"
                
                
            }
            
            else if match.score.count >= 2 {
                inning1L.text = "Innings: \(match.score[0].inning)"
                run1L.text = "Runs: \(Int(match.score[0].r))"
                wic1L.text = "Wickets: \(Int(match.score[0].w))"
                over1L.text = "Overs: \(String(match.score[0].o))"
                inning2L.text = "Innings: \(match.score[1].inning)"
                run2L.text = "Runs: \(Int(match.score[1].r))"
                wic2L.text = "Wickets: \(Int(match.score[1].w))"
                over2L.text = "Overs: \(String(match.score[1].o))"
                
            }
            else {
                inning1L.text = "NA"
                run1L.text = "NA"
                wic1L.text = "NA"
                over1L.text = "NA"
                inning2L.text = "NA"
                run2L.text = "NA"
                wic2L.text = "NA"
                over2L.text = "NA"
            }
            
        }
        
    }
    
   
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else {
                return
                
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
            
        }.resume()
        
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit)
    {
        guard let url = URL(string: link)
        else {
                        return
                        
            }
            downloaded(from: url, contentMode: mode)
    }
}

