//
//  TeamDetailsViewController.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
    let indicator=UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var team : Team?
    var viewModel : TeamDetailsViewModel<TeamResult>!
    var sportName : String!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        team?.players = []
        
        let cellNib = UINib(nibName:"playerView", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:"playerCell")
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        viewModel = TeamDetailsViewModel<TeamResult>(networkManager: NetworkManager.sharedInstance)
        
        getTeamDetails()
    }
    
    func getTeamDetails(){
        indicator.startAnimating()
        
        viewModel.bindTeamDetails = { [weak self] in
            DispatchQueue.main.async {
            
                self?.team = self?.viewModel.result?.result[0]
                self?.updateUI()
                self?.indicator.stopAnimating()
            }
        }
        viewModel.getTeamDetails(teamKey: (team?.team_key) ?? 0)
    }
    
    
    func updateUI(){
        
        let imgUrl = URL(string: team?.team_logo ?? getTeamPlaceolder(sportName: sportName))
        img?.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: getTeamPlaceolder(sportName: sportName)))
        
        nameLabel.text = team?.team_name
        
        tableView.reloadData()
    }

}


extension TeamDetailsViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
   
        let imgUrl = URL(string: team?.players![indexPath.row].player_image ?? "player")

        cell.img?.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: "player"))
        
        cell.nameLabel.text = team?.players![indexPath.row].player_name ?? "No name"
        cell.playerNo.text = team?.players![indexPath.row].player_number ?? ""
     //   dump(team?.players)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (team?.players?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }
   
}
