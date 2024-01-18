//
//  TrackingViewController.swift
//  Coordinator-Lab
//
//  Created by 김민준 on 1/18/24.
//

import UIKit

final class TrackingViewController: TestViewController {
    
    /// Coordinator 생성
    weak var coordinator: TrackingCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupEvent()
        viewLabel.text = "TrackingViewController"
    }
    
    deinit {
        coordinator?.remove()
    }
    
    private func setupEvent() {
        
        firstButton.setTitle("Block", for: .normal)
        firstButton.addTarget(
            self,
            action: #selector(pushBlockView),
            for: .touchUpInside
        )
        
//        secondButton.addTarget(
//            self,
//            action: #selector(pushCalendarView),
//            for: .touchUpInside
//        )
    }
}

// MARK: - Event Method
extension TrackingViewController {
    @objc private func pushBlockView() {
        coordinator?.pushBlockView()
    }
}
