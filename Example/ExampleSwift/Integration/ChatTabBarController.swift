//
//  ChatTabBarController.swift
//  ExampleSwift
//
//  Created by Artem Shapovalov on 12.09.2023.
//  Copyright © 2023 Threads. All rights reserved.
//

import UIKit

class ChatTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tabBar.frame.size.height = 100
        tabBar.frame.origin.y = view.frame.height - 100
        tabBar.backgroundColor = .white
    }
}
