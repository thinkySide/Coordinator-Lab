//
//  BlockCoordinator.swift
//  Coordinator-Lab
//
//  Created by 김민준 on 1/18/24.
//

import UIKit

/// App - Home - Calendar
final class BlockCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("BlockCoordinator - \(#function)")
        
        let blockVC = BlockViewController()
        blockVC.coordinator = self
        navigationController.pushViewController(blockVC, animated: true)
        
        print("BlockCoordinator parent: \(parentCoordinator)")
        print("BlockCoordinator childs: \(childCoordinators)\n")
    }
    
    func remove() {
        parentCoordinator?.removeChildCoordinator(child: self)
    }
}
