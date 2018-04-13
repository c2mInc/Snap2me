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
    lazy var draggableView :Snap2meView = {
        let view = Snap2meView(frame: CGRect(x: 100, y: 100, width: 60, height: 60))
        view.backgroundColor = UIColor.clear
        let 🎃 = UILabel()
        🎃.text = "🎃"
        🎃.textAlignment = .center
        🎃.font = UIFont.systemFont(ofSize: 39.0)
        🎃.bounds.size = view.bounds.size
        🎃.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(🎃)
        
        view.axisPercentages = [
            GuideLine.AxisPercentage(axis: .vertical, percentage: 0.5),
            GuideLine.AxisPercentage(axis: .horizontal, percentage: 0.5),
            GuideLine.AxisPercentage(axis: .horizontal, percentage: 0.1),
            GuideLine.AxisPercentage(axis: .vertical, percentage: 0.1),
            GuideLine.AxisPercentage(axis: .horizontal, percentage: 0.9),
            GuideLine.AxisPercentage(axis: .vertical, percentage: 0.9)
        ]
        
        return view
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        let gridView = UIView()
        
        draggableView.programmaticDraggingView = gridView
        gridView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(gridView)
        self.view.addSubview(draggableView)
        
        draggableView.settings = GuideLine.Settings(lineColor: UIColor.red, lineWidth: 4, shadowColor: UIColor.brown, flushesInitially: true, threshold: 15)
        
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
