//
//  MyCoreData.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import UIKit
import CoreData

class MyCoreData {
    
    var manager : NSManagedObjectContext!
    var leagueArr : [NSManagedObject] = []
    var leagueToBeDeleted : NSManagedObject?
    
    static let sharedInstance = MyCoreData()
    
    private init(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    
        func getStoredLeagues() -> [League]{
    
            var leagues = [League]()
    
            let fetch = NSFetchRequest<NSManagedObject>(entityName: "Fav")
    
            do{
                leagueArr = try manager.fetch(fetch)
                if(leagues.count > 0){
                    leagueToBeDeleted = leagueArr.first
                }
    
                for item in leagueArr{
                    var league = League()
                    league.league_key = item.value(forKey: "league_key") as? Int ?? 0
                    league.league_logo = item.value(forKey: "league_logo") as? String ?? ""
                    league.league_name = item.value(forKey: "league_name") as? String ?? ""
                    league.country_key = item.value(forKey: "country_key") as? Int ?? 0
                    league.country_logo = item.value(forKey: "country_logo") as? String ?? ""
                    league.country_name = item.value(forKey: "country_name") as? String ?? ""
                    league.sportName = item.value(forKey: "sportName") as! String ?? ""
                    
                    leagues.append(league)
                }
    
            }catch let error{
                print(error.localizedDescription)
            }
    
            return leagues
    
        }
    
        func insertLeague(league : League){
    
            let entity = NSEntityDescription.entity(forEntityName: "Fav", in: manager)

            let league1 = NSManagedObject(entity: entity!, insertInto: manager)
            league1.setValue(league.league_key, forKey: "league_key")
            league1.setValue(league.league_name, forKey: "league_name")
            league1.setValue(league.league_logo, forKey: "league_logo")
            league1.setValue(league.country_key, forKey: "country_key")
            league1.setValue(league.country_name, forKey: "country_name")
            league1.setValue(league.country_logo, forKey: "country_logo")
            league1.setValue(league.sportName, forKey: "sportName")
            
            do{
                try manager.save()
                print("Saved!")
            }catch let error{
                print(error.localizedDescription)
            }
    
        }
    
        func deleteLeague(league : League){
            for item in leagueArr{
                if ((item.value(forKey: "league_key") as! Int) == league.league_key){
    
                    leagueToBeDeleted = item
                }
            }
    
            guard let league1 = leagueToBeDeleted else{
                print("cannot be deleted!")
                return
            }
            manager.delete(league1)
            do{
                try manager.save()
                print("Deleted!")
                leagueToBeDeleted = nil
            }catch let error{
                print(error.localizedDescription)
            }
        }
    
    
    func isLeagueExist(league : League) -> Bool{
                
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Fav")
        
        let predicate = NSPredicate(format: "league_key == %d", league.league_key!)
        
        fetch.predicate = predicate
        do{
            leagueArr = try manager.fetch(fetch)
            if(leagueArr.count > 0){
                print("Fav is exist")
                return true
            }else{
                return false
            }

            
        }catch let error{
            print(error.localizedDescription)
        }
        
        return false
    }
    
    

    
}
