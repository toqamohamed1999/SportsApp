//
//  SplashViewController.swift
//  Sports2
//
//  Created by Mac on 22/05/2023.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 2. Start LottieAnimationView with animation name (without extension)
        
        animationView = .init(name: "sports")
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        animationView!.frame = CGRect(x: w/2-100, y: h/2-100, width: 200, height: 200)
        
        // 3. Set animation content mode
        
        animationView!.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        
        animationView!.animationSpeed = 0.5
        
        view.addSubview(animationView!)
        
        // 6. Play animation
        
        animationView!.play()
        
        loadNextVC()
    }
    
    func loadNextVC() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        
            let tabBarView = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! TabBarController;

            self.navigationController?.pushViewController(tabBarView, animated: true)

        }
    }
    

}
