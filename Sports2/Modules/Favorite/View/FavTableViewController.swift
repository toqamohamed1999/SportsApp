//
//  FavTableViewController.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import UIKit

class FavTableViewController: UITableViewController {

    @IBOutlet weak var noFavImg: UIImageView!
    let indicator=UIActivityIndicatorView(style: .large)
    
    var leaguesArr : [League] = []
    var viewModel : FavViewModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        noFavImg.image = UIImage(named: "")
        self.tableView.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 0,right: 0)

        
        let cellNib = UINib(nibName:"LeagueView", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:"leagueCell")
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        viewModel = FavViewModel(networkManager: NetworkManager.sharedInstance,myCoreData: MyCoreData.sharedInstance)

        getStoredLeagues()
    }
    
    func getStoredLeagues(){
        indicator.startAnimating()
        
        viewModel.bindStoredLeagues = { [weak self] in
            DispatchQueue.main.async {

                self?.leaguesArr = (self?.viewModel.result)!
                if(self?.leaguesArr.count == 0){
                    self?.noFavImg.image = UIImage(named: "noFav")
                }else{
                    self?.noFavImg.image = UIImage(named: "")
                }
                self?.tableView.reloadData()
                self?.indicator.stopAnimating()
            }
        }
        viewModel.getStoredLeagues()
    }
    

}


extension FavTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
   
//        let imgUrl = URL(string: leaguesArr[indexPath.row].league_logo ?? "league")
//
//        cell.img.makeRounded()
//        cell.img?.kf.setImage(
//            with: imgUrl,
//            placeholder: UIImage(named: "league.png"))
        
        let imageData = Data(base64Encoded: leaguesArr[indexPath.row].league_logo ?? "league" ) ?? Data()
        cell.img?.image = UIImage(data: imageData)
        
        cell.nameLabel.text = leaguesArr[indexPath.row].league_name ?? "No name"
        
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leaguesArr.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let leaguesDetailsView = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails2") as! LeagueDetailsVC;

        leaguesDetailsView.sportName = leaguesArr[indexPath.row].sportName ?? "football"
                
        leaguesDetailsView.league = leaguesArr[indexPath.row]

        self.present(leaguesDetailsView, animated:true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.getStoredLeagues()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            showAlert(index: indexPath.row)
            
        }
    }
    
    func deleteLeague(index : Int){
        let league : League = leaguesArr[index]
        
        self.viewModel.deleteLeague(league: league)
        self.showToast(message: "League removed from favorite", font: .systemFont(ofSize: 12.0))
        
        viewModel.getStoredLeagues()
        tableView.reloadData()
    }
    
    
    func showAlert(index : Int){
        
        let alert : UIAlertController = UIAlertController(title: "Delete League", message: "Are you sure that, Do yo want to delete this league?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            self.deleteLeague(index: index)
            
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }


}
