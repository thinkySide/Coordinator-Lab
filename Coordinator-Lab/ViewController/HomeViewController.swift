//
//  HomeViewController.swift
//  Coordinator-Lab
//
//  Created by 김민준 on 1/18/24.
//

import UIKit

final class HomeViewController: TestViewController {
    
    /// Coordinator 생성
    weak var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEvent()

        viewLabel.text = "HomeViewController"
    }
    
    private func setupEvent() {
        pushButton.addTarget(
            self,
            action: #selector(pushTrackingView),
            for: .touchUpInside
        )
    }
}

// MARK: - Event Method
extension HomeViewController {
    @objc private func pushTrackingView() {
        coordinator?.pushTrackingView()
    }
}

