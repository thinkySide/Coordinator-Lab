//
//  HomeCoordinator.swift
//  Coordinator-Lab
//
//  Created by 김민준 on 1/18/24.
//

import UIKit

/// 최상위 바로 아래 코디네이터(Home)
final class HomeCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("HomeCoordinator - \(#function)")
        
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: false)
        
        print("HomeCoordinator parent: \(parentCoordinator)")
        print("HomeCoordinator childs: \(childCoordinators)\n")
    }
    
    /// 최상위 Coordinator는 해제되면 안됨
    func remove() {}
}

// MARK: - 화면 전환 메서드
extension HomeCoordinator {
    
    /// 트래킹 뷰로 Push 메서드
    func pushTrackingView() {
        let trackingCoordinator = TrackingCoordinator(navigationController: navigationController)
        
        childCoordinators.append(trackingCoordinator)
        trackingCoordinator.parentCoordinator = self
        trackingCoordinator.start()
    }
    
    /// 캘린더 뷰로 Push 메서드
    func pushCalendarView() {
        let calendarCoordinator = CalendarCoordinator(navigationController: navigationController)
        
        childCoordinators.append(calendarCoordinator)
        calendarCoordinator.parentCoordinator = self
        calendarCoordinator.start()
    }
}
