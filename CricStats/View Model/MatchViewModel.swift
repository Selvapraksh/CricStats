

import Foundation
import Network



class MatchViewModel {
    
    let monitor = NWPathMonitor()
    
    var isConnected = false
    

    init() {
        
        monitor.pathUpdateHandler = { nwPath in
            switch nwPath.status{
            case .satisfied:
                print("Connection available")
                self.isConnected = true
            case .unsatisfied:
                print("No Connection")
                self.isConnected = false
                
            case .requiresConnection:
                print("Connecting...")
                self.isConnected = false
            
            default:
                break
            }
        }
        
        monitor.start(queue: DispatchQueue(label: "myqueue"))
        
    }
    

    let matchModel = CricketUtility.shared
    
    func getMatches(callback: @escaping ([MatchDetails]) -> Void)  {
        
        if isConnected {
            matchModel.getCurrentMatches(handler: callback)
        }
        else {
        }
    }
    
}


