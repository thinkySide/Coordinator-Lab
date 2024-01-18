//
//  CalendarCoordinator.swift
//  Coordinator-Lab
//
//  Created by 김민준 on 1/18/24.
//

import UIKit

/// App - Home - Calendar
final class CalendarCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("CalendarCoordinator - \(#function)")
        
        let calendarVC = CalendarViewController()
        calendarVC.coordinator = self
        navigationController.pushViewController(calendarVC, animated: true)
        
        print("CalendarCoordinator parent: \(parentCoordinator)")
        print("CalendarCoordinator childs: \(childCoordinators)\n")
    }
    
    func remove() {
        parentCoordinator?.removeChildCoordinator(child: self)
    }
}
