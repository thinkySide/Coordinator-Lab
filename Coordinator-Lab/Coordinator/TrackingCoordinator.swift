//
//  TrackingCoordinator.swift
//  Coordinator-Lab
//
//  Created by 김민준 on 1/18/24.
//

import UIKit

/// App - Home - Tracking
final class TrackingCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("TrackingCoordinator - \(#function)")
        
        let trackingViewController = TrackingViewController()
        trackingViewController.coordinator = self
        navigationController.pushViewController(trackingViewController, animated: true)
        
        print("TrackingCoordinator parent: \(parentCoordinator)")
        print("TrackingCoordinator childs: \(childCoordinators)\n")
    }
}
