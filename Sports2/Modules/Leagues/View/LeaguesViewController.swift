//
//  LeaguesViewController.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import UIKit
import Kingfisher
import Alamofire

class LeaguesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let indicator=UIActivityIndicatorView(style: .large)
    
    var leaguesArr : [League] = []
    var filterLeaguesArr : [League] = []
    var sportName = ""
    var league = League()
    var isFiltered = false
    var viewModel : LeaguesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let cellNib = UINib(nibName:"LeagueView", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:"leagueCell")
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        viewModel = LeaguesViewModel(networkManager: NetworkManager.sharedInstance)
        
        getLeauges()
    
    }
    

    func getLeauges(){
        indicator.startAnimating()
        
        viewModel.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
            
                self?.leaguesArr = self?.viewModel.result ?? []
                self?.tableView.reloadData()
                self?.indicator.stopAnimating()
                
            }
        }
        viewModel.getLeagues(sportName: sportName.lowercased())
    }
}


extension LeaguesViewController : UITableViewDelegate,UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        
        getLeagueValue(index: indexPath.row)
   
        cell.nameLabel.text = league.league_name ?? "No name"
        let imgUrl = URL(string: league.league_logo ?? getLeaguePlaceolder())

        cell.img.makeRounded()
        cell.img?.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: getLeaguePlaceolder()))
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(isFiltered){
            return filterLeaguesArr.count;
        }
        return leaguesArr.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let leaguesDetailsView = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails2") as! LeagueDetailsVC;

        leaguesDetailsView.sportName = sportName
        
        getLeagueValue(index: indexPath.row)
        
        leaguesDetailsView.league = league

        self.present(leaguesDetailsView, animated:true, completion: nil)
        
    }
    
    

}

extension LeaguesViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        if(searchText.count == 0){
            isFiltered = false;
        }
        else{
            isFiltered = true;
            filterLeaguesArr.removeAll();
            
            for league in leaguesArr{

                if ((league.league_name!.lowercased().contains(searchText.lowercased()))){
                    
                    filterLeaguesArr.append(league)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    func getLeagueValue(index : Int){
        
        if(isFiltered){
            league = filterLeaguesArr[index];
        }else{
            league = leaguesArr[index];
        }
    }
    
    func getLeaguePlaceolder() -> String{
        
        print(sportName)
        
        switch(sportName){
            
        case "Football" : return "soccerLeague "
        case "Basketball" : return "basketLeague"
        case "Cricket" : return "cricketLeague"
        case "Tennis" : return "tennisLeague"
            
        default:
            return "soccerLeague"
        }
    }
    
}
