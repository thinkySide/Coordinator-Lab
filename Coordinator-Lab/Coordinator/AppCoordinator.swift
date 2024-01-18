//
//  AppCoordinator.swift
//  Coordinator-Lab
//
//  Created by 김민준 on 1/18/24.
//

import UIKit

/// 최상위 Coordinator
final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// RootViewController로 보일 화면 지정
    func start() {
        print("AppCoordinator - \(#function)")
        
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        
        /// 홈화면의 부모는 자신
        homeCoordinator.parentCoordinator = self
        
        /// 자신의 자식 목록에 홈 화면 추가
        childCoordinators.append(homeCoordinator)
        
        /// 홈 화면 코디네이터 세팅 완료
        homeCoordinator.start()
        
        print("AppCoordinator childs: \(childCoordinators)\n")
    }
}
