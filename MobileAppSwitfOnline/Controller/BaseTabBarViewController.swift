//
//  BaseTabBarViewController.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 13/3/26.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      

      //MARK: - Passing the controllers to the NavTabBarController
     viewControllers =  [creatingNavTabBArController(viewController: PopularViewController(), image: "house", titleLarge: true, title: "Home"),
      creatingNavTabBArController(viewController: ViewController(), image: "magnifyingglass", titleLarge: true, title: "Search"),
      creatingNavTabBArController(viewController: ViewController(), image: "star", titleLarge: true, title: "Top Rated"),
      creatingNavTabBArController(viewController: ViewController(), image: "square.and.arrow.down", titleLarge: true, title: "Download")]
    }
    
// MARK: - Func to create a NavTabBar customizaded

  fileprivate func creatingNavTabBArController(viewController: UIViewController, image: String, titleLarge: Bool, title: String) -> UIViewController {
    
    let navTabBarController = UINavigationController(rootViewController: viewController)
    navTabBarController.navigationBar.prefersLargeTitles = titleLarge
    navTabBarController.tabBarItem.image = UIImage(systemName: image)
    navTabBarController.tabBarItem.title = title
    viewController.navigationItem.title = title
    viewController.view.backgroundColor = .white
  
    return navTabBarController
  }

}
