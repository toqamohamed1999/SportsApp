//
//  LeagueDetailsVC.swift
//  Sports2
//
//  Created by Mac on 22/05/2023.
//

import UIKit
import Reachability

class LeagueDetailsVC: UIViewController {
    
    
    @IBOutlet weak var loadedImg: UIImageView!
    @IBOutlet weak var noInternetImg: UIImageView!
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var upcomingView: UICollectionView!
    @IBOutlet weak var teamsView: UICollectionView!
    
    @IBOutlet weak var latestView: UICollectionView!
    let indicator=UIActivityIndicatorView(style: .large)
    
    var sportName = ""
    var league = League()
    var upcomingArr : [Event] = []
    var previousArr : [Event] = []
    var teamsDic = [Int:Team]()
    var teamsArr : [Team] = []
    var viewModel : LeagueDetailsViewModel!
    var reachability : Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noInternetImg.image = UIImage(named: "")

        upcomingView.delegate = self
        upcomingView.dataSource = self
        latestView.delegate = self
        latestView.dataSource = self
        teamsView.delegate = self
        teamsView.dataSource = self
        
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        upcomingView.register(UINib(nibName: "EventCell", bundle: .main), forCellWithReuseIdentifier: "eventCell")
        
        latestView.register(UINib(nibName: "EventCell", bundle: .main), forCellWithReuseIdentifier: "eventCell")
        
        teamsView.register(UINib(nibName: "TeamCell", bundle: .main), forCellWithReuseIdentifier: "teamCell")
                
        
        viewModel = LeagueDetailsViewModel(networkManager: NetworkManager.sharedInstance,myCoreData: MyCoreData.sharedInstance)
        
        let imgUrl = URL(string: league.league_logo ?? "league")
        loadedImg?.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: "league"))
        
        checkNetwork()
        setUPFavAction()
        
    }
    
    func checkNetwork(){
        
        do{
            reachability = try Reachability()
            try reachability?.startNotifier()
        }
                
        catch{
                   
            print("cant creat object of rechability")
            print("Unable to start notifier")
        }
        
        getData()
        
    }
    
    func getData(){
        reachability?.whenReachable = { reachability in
            
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                
            } else {
                print("Reachable via Cellular")
            }
            
            self.noInternetImg.image = UIImage(named: "")
            self.getUpcomingEvents()
            self.getPreviousEvents()
        }
    
        reachability?.whenUnreachable = { _ in
            print("Not reachable")
            self.noInternetImg.image = UIImage(named: "noInternet")
           
        }
        
    }
    
    
    func getUpcomingEvents(){
        indicator.startAnimating()
        
        viewModel.bindUpcomingEvents = { [weak self] in
            DispatchQueue.main.async {
                
                self?.upcomingArr = self?.viewModel.upcomingResult ?? []
                self?.upcomingView.reloadData()
            }
        }
        viewModel.getUpcomingEvents(sportName: sportName.lowercased(), leagueId: league.league_key!)
    }
    
    func getPreviousEvents(){
        indicator.startAnimating()
        
        viewModel.bindPreviousEvents = { [weak self] in
            DispatchQueue.main.async {
                
                self?.previousArr = self?.viewModel.previousResult ?? []
                self?.getTeams()
                self?.latestView.reloadData()
                self?.teamsView.reloadData()
                self?.indicator.stopAnimating()
                
            }
        }
        viewModel.getPreviousEvents(sportName: sportName.lowercased(), leagueId: league.league_key!)
    }
    
    
    func getTeams(){
        
        let arr = upcomingArr + previousArr
        
        for event in arr {
            
            teamsDic.updateValue(Team(team_key: event.home_team_key,team_name: event.event_home_team, team_logo: event.home_team_logo), forKey: event.home_team_key!)
            
            teamsDic.updateValue(Team(team_key: event.away_team_key,team_name: event.event_away_team, team_logo: event.away_team_logo), forKey: event.away_team_key!)
            
        }
        
        teamsArr = Array(teamsDic.values)
    }
    
    func setUPFavAction(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addToFav(_ :)))
        favImage.addGestureRecognizer(tap)
        
       
        if (viewModel.isLeagueExist(league: league)) {
        
            favImage.image = UIImage(named: "redHeart2")

        } else {
            favImage.image = UIImage(named: "heart2")
        }

    }
    
    @objc func addToFav(_ sender: UITapGestureRecognizer ) {
        
        if(viewModel.isLeagueExist(league: league)){
            
            favImage.image = UIImage(named: "heart2")
            viewModel.deleteLeague(league: league)
            self.showToast(message: "League removed from favorite", font: .systemFont(ofSize: 12.0))
        }else{
            //save image as data
            let imageData = loadedImg.image?.pngData()?.base64EncodedString() ?? "league"
            league.league_logo = imageData
            
            favImage.image = UIImage(named: "redHeart2")
            league.sportName = sportName
            viewModel.insertLeague(league: league)
            self.showToast(message: "League added to favorite", font: .systemFont(ofSize: 12.0))
        }
    }
    


}


extension LeagueDetailsVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.upcomingView{
            return upcomingArr.count
        }
        return teamsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.upcomingView{
            
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
            
            
            let imgUrl = URL(string: upcomingArr[indexPath.row].home_team_logo ?? "soccer")
            cell.img1?.kf.setImage(
                with: imgUrl,
                placeholder: UIImage(named: "soccer"))
            
            let imgUrl2 = URL(string: upcomingArr[indexPath.row].away_team_logo ?? "soccer")
            cell.img2?.kf.setImage(
                with: imgUrl2,
                placeholder: UIImage(named: "soccer"))
            
            cell.teamName1.text = upcomingArr[indexPath.row].event_home_team
            cell.teamName2.text = upcomingArr[indexPath.row].event_away_team
            cell.dateLabel.text = upcomingArr[indexPath.row].event_date
            cell.timeLabel.text = upcomingArr[indexPath.row].event_time
            
            
            return cell
            
        }else if collectionView == self.latestView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
    
             let imgUrl = URL(string: previousArr[indexPath.row].home_team_logo ?? "soccer")
             cell.img1?.kf.setImage(
                 with: imgUrl,
                 placeholder: UIImage(named: "soccer"))
    
             let imgUrl2 = URL(string: previousArr[indexPath.row].away_team_logo ?? "soccer")
             cell.img2?.kf.setImage(
                 with: imgUrl2,
                 placeholder: UIImage(named: "soccer"))
    
            cell.teamName1.text = previousArr[indexPath.row].event_home_team
            cell.teamName2.text = previousArr[indexPath.row].event_away_team
            cell.dateLabel.text = previousArr[indexPath.row].event_date
            cell.timeLabel.text = previousArr[indexPath.row].event_final_result
    
            return cell

        }else if collectionView == self.teamsView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCell
                         
            let imgUrl = URL(string: teamsArr[indexPath.row].team_logo ?? "soccer")
             cell.img?.kf.setImage(
                 with: imgUrl,
                 placeholder: UIImage(named: "soccer"))

            cell.nameLabel.text = teamsArr[indexPath.row].team_name
             
             return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
       if collectionView == self.teamsView{
           
           let teamView = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController;

           teamView.team = teamsArr[indexPath.row]

           self.present(teamView, animated:true, completion: nil)
       }
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.teamsView{

            return CGSize(width: UIScreen.main.bounds.width/3, height: 160)
        }
        if collectionView == self.latestView{
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 160)
        }
        
        return CGSize(width: UIScreen.main.bounds.width - 16, height: 160)
    }
    
    
}
