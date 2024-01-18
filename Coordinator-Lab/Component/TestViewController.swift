//
//  TestViewController.swift
//  Coordinator-Lab
//
//  Created by 김민준 on 1/18/24.
//

import UIKit
import SnapKit

/// 테스트를 위한 뷰컨
class TestViewController: UIViewController {
    
    let viewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "", size: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("FIRST", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("SECOND", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.isUserInteractionEnabled = true
        return button
    }()
    
    // MARK: - Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white

        // AutoLayout 설정
        [viewLabel, firstButton, secondButton].forEach { view.addSubview($0) }
        
        viewLabel.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        firstButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(48)
            make.leading.equalTo(view.snp.leading).offset(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(32)
        }
        
        secondButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(48)
            make.trailing.equalTo(view.snp.trailing).inset(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
