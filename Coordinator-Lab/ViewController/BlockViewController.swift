//
//  BlockViewController.swift
//  Coordinator-Lab
//
//  Created by 김민준 on 1/18/24.
//

import UIKit

final class BlockViewController: TestViewController {
    
    /// Coordinator 생성
    weak var coordinator: BlockCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewLabel.text = "BlockViewController"
    }
}
