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
        viewLabel.text = "TrackingViewController"
    }
}
