//
//  LeagueDetailsVC.swift
//  Sports2
//
//  Created by Mac on 22/05/2023.
//

import UIKit
import Reachability
import Lottie

class LeagueDetailsVC: UIViewController {
    
    @IBOutlet weak var teamsLAbel: UILabel!
    @IBOutlet weak var upcomingLAbel: UILabel!
    
    @IBOutlet weak var latestLAbel: UILabel!
    @IBOutlet weak var loadedImg: UIImageView!
    @IBOutlet weak var noInternetImg: UIImageView!
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var upcomingView: UICollectionView!
    @IBOutlet weak var teamsView: UICollectionView!
    
    @IBOutlet weak var latestView: UICollectionView!
    let indicator=UIActivityIndicatorView(style: .large)
    private var animationView: LottieAnimationView?

    
    var sportName = ""
    var league = League()
    var upcomingArr : [Event] = []
    var previousArr : [Event] = []
    var teamsDic = [Int:Team]()
    var teamsArr : [Team] = []
    var viewModel : LeagueDetailsViewModel<EventResult>!
    var reachability : Reachability!
    var deleteProtocol : DeleteFavPrortocol!
    
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
        
        viewModel = LeagueDetailsViewModel(networkManager: NetworkManager.sharedInstance,myCoreData: MyCoreData.sharedInstance)
        
        registerNibCells()
        loadLeagueImage()
        checkNetwork()
        setUPFavAction()
    }
    
    func registerNibCells(){
        upcomingView.register(UINib(nibName: "EventCell", bundle: .main), forCellWithReuseIdentifier: "eventCell")
        
        latestView.register(UINib(nibName: "EventCell", bundle: .main), forCellWithReuseIdentifier: "eventCell")
        
        teamsView.register(UINib(nibName: "TeamCell", bundle: .main), forCellWithReuseIdentifier: "teamCell")
    }
    
    func loadLeagueImage(){
        
        let imgUrl = URL(string: league.league_logo ?? getLeaguePlaceolder(sportName: sportName))
        loadedImg?.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: getLeaguePlaceolder(sportName: sportName)))
    }
    
    func checkNetwork(){
        
        do{
            reachability = try Reachability()
            try reachability?.startNotifier()
        }
                
        catch{
            print("cant creat object of rechability")
        }
        
        getData()
        
    }
    
    func getData(){
        reachability?.whenReachable = { reachability in
            
            self.showLabels()
            self.noInternetImg.image = UIImage(named: "")
            self.getUpcomingEvents()
            self.getPreviousEvents()
        }
    
        reachability?.whenUnreachable = { _ in
            print("Not reachable")
            self.noInternetImg.image = UIImage(named: "noInternet")
            self.hideLabels()
           
        }
        
    }
    
    
    func getUpcomingEvents(){
        indicator.startAnimating()
        
        viewModel.bindUpcomingEvents = { [weak self] in
            DispatchQueue.main.async {
                
                self?.upcomingArr = self?.viewModel.upcomingResult.result ?? []
                self?.upcomingView.reloadData()
            }
        }
        viewModel.getUpcomingEvents(sportName: sportName.lowercased(), leagueId: league.league_key!)
    }
    
    func getPreviousEvents(){
        indicator.startAnimating()
        
        viewModel.bindPreviousEvents = { [weak self] in
            DispatchQueue.main.async {
                
                self?.previousArr = self?.viewModel.previousResult.result ?? []
                if(self?.previousArr.count == 0){ self?.dataNotFound()}
                else{
                    self?.getTeams()
                    self?.latestView.reloadData()
                    self?.teamsView.reloadData()
                    self?.indicator.stopAnimating()
                }
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
            self.showToast(message: "removed from favorite", font: .systemFont(ofSize: 12.0))
        }else{
            //save image as data
            let imageData = loadedImg.image?.pngData()?.base64EncodedString() ?? getLeaguePlaceolder(sportName: sportName)
            league.league_logo = imageData
            
            favImage.image = UIImage(named: "redHeart2")
            league.sportName = sportName
            viewModel.insertLeague(league: league)
            self.showToast(message: "added to favorite", font: .systemFont(ofSize: 12.0))
        }
        
        if(deleteProtocol != nil){ deleteProtocol.notifyDeletFav()}
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
            
            cell.changeData(event: upcomingArr[indexPath.row], sportName: sportName, eventType: "upcoming")
            
            return cell
            
        }else if collectionView == self.latestView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
    
            cell.changeData(event: previousArr[indexPath.row], sportName: sportName, eventType: "latest")
    
            return cell

        }else if collectionView == self.teamsView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCell

            cell.changeData(team: teamsArr[indexPath.row],sportName: sportName)
             
             return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
       if collectionView == self.teamsView{
           
           let teamView = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController;

           teamView.team = teamsArr[indexPath.row]
           
           teamView.sportName = sportName

           self.present(teamView, animated:true, completion: nil)
       }
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        if collectionView == self.teamsView{

            return CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/5.3)
        }
        if collectionView == self.latestView{
            return CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height/5.3)
        }
        
        return CGSize(width: UIScreen.main.bounds.width - 16, height: UIScreen.main.bounds.height/5.3)
    }
    

    
    
    func dataNotFound(){
        hideLabels()
        
        animationView = .init(name: "noData")
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        animationView!.frame = CGRect(x: w/2-200, y: h/2-250, width: 400, height: 400)
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
    
        animationView!.play()
        
    }
    
    func hideLabels(){
        teamsLAbel.text = ""
        upcomingLAbel.text = ""
        latestLAbel.text = ""
    }
    
    func showLabels(){
        teamsLAbel.text = "League Teams"
        upcomingLAbel.text = "Upcoming Events"
        latestLAbel.text = "Latest Events"
    }
    
}
