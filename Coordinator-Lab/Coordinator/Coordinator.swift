//
//  Coordinator.swift
//  Coordinator-Lab
//
//  Created by 김민준 on 1/18/24.
//

import UIKit

protocol Coordinator: AnyObject {
    
    /// ViewController의 Push, Pop을 위한 NavigationController
    var navigationController: UINavigationController { get }
    
    /// 현재 코디네이터의 상위 객체 (부모)
    var parentCoordinator: Coordinator? { get set }
    
    /// 현재 코디네이터의 하위(자식) 객체들
    var childCoordinators: [Coordinator] { get set }
    
    /// Coordinator 설정 완료
    func start()
}
