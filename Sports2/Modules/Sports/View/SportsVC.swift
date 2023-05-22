//
//  SportsVC.swift
//  Sports2
//
//  Created by Mac on 22/05/2023.
//

import UIKit

class SportsVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var sportsNames : [String] = ["Football","Basketball","Cricket","Tennis"]
    var sportsImgs : [String] = ["football","basket1","cricket2","tennis1"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension SportsVC : UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout  {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sportsNames.count
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportsCell", for: indexPath)
        as! SportsCell
        
        cell.nameLabel.text = sportsNames[indexPath.row]
        cell.img.makeRounded()
        cell.img.image = UIImage(named: sportsImgs[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.size.width/2 - 16), height: 200)
    }
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let leaguesView = self.storyboard?.instantiateViewController(withIdentifier: "leaguesScreen") as! LeaguesViewController;

        leaguesView.sportName = sportsNames[indexPath.row]

        self.present(leaguesView, animated:true, completion: nil)
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
    
    
}

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

extension UIImageView {

    func makeRounded() {
           
           layer.borderWidth = 1
           layer.masksToBounds = false
           layer.borderColor = UIColor.black.cgColor
           layer.cornerRadius = self.frame.height / 2
           clipsToBounds = true
       }
    
    func makeRoundedWithoutBorder() {
           
           layer.borderWidth = 0
           layer.masksToBounds = false
           layer.borderColor = UIColor.white.cgColor
           layer.cornerRadius = self.frame.height / 2
           clipsToBounds = true
       }
}
