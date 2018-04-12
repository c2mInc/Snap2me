//
//  SwiftViewController.swift
//  Snap2me_Example
//
//  Created by Erk Ekin on 12.04.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Snap2me

class SwiftViewController: UIViewController {
    let draggableView = Snap2meView(frame: CGRect(x: 100, y: 100, width: 32, height: 32))
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        draggableView.backgroundColor = UIColor.gray
        let gridView = UIView()

        draggableView.programmaticDraggingView = gridView
        gridView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(gridView)
        self.view.addSubview(draggableView)
        
        NSLayoutConstraint.activate(
        [
            gridView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
            gridView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            gridView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            gridView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ]
        )
        
        gridView.backgroundColor = UIColor.yellow

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        debugPrint(size)
        debugPrint(coordinator)
    }
}
