//
//  ContainerVC.swift
//  ExampleSwift
//
//  Created by Artem Shapovalov on 12.09.2023.
//  Copyright © 2023 Threads. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    
    var chatVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(chatVC)
        view.addSubview(chatVC.view)
        
        chatVC.view.translatesAutoresizingMaskIntoConstraints = false
        /// Когда оффсета нет, то текст инпут попадает под таббар
//        let magicOffset: CGFloat = 0
        /// Когда пытаемся добавить оффсет для вью, верстка ломается
        let magicOffset: CGFloat = -100
        
        NSLayoutConstraint.activate([
            chatVC.view.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            chatVC.view.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            chatVC.view.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            chatVC.view.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -magicOffset
            )
        ])
        
        chatVC.didMove(toParent: self)
    }
}
