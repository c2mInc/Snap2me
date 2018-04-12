//
//  ViewThatYouDragOn.swift
//  Snap2me_Example
//
//  Created by Erk Ekin on 11.04.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Snap2me

class ViewThatYouDragOn:UIView{
    
    @IBOutlet weak var draggingView: DraggingView!
    var lines:Set<GuideLine> = Set<GuideLine>()
    var gridsRendered:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGestureRecognizers()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard gridsRendered ==  false else {return}
               debugPrint(frame.size)
        gridsRendered = true
        lines = GuideLine.create(intersectionPoints: [CGPoint(x: bounds.midX, y: bounds.midY)], size: frame.size)
        lines.forEach{
            self.layer.addSublayer($0.layer)
        }
        
    }
    @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case .changed:
            let draggingPoint = gestureRecognizer.location(in: self)
            let lines = checkForSnappingGrid(gestureRecognizer: gestureRecognizer)
            
            if let line = lines.first, lines.count == 1{
                line.layer.opacity = 0.3
                self.lines.subtracting(lines).forEach{$0.layer.opacity = 0}
                switch line.axis {
                case .horizontal:
                    self.viewToSnap?.center.x = line.distance
                    self.viewToSnap?.center.y = draggingPoint.y
                case .vertical:
                    self.viewToSnap?.center.y = line.distance
                    self.viewToSnap?.center.x = draggingPoint.x
                }
                
            }else if lines.count > 1{
                self.viewToSnap?.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
                for line in lines{
                    line.layer.opacity = 0.3
                }
            }else{
                
                self.viewToSnap?.center = draggingPoint
                
                for line in self.lines{
                    line.layer.opacity = 0.0
                }
            }
            
        case .ended:
            for line in self.lines{
                line.layer.opacity = 0.0
            }
        default:
            break
        }
    }
}


extension ViewThatYouDragOn : UIGestureRecognizerDelegate {
    
    func configureGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(panGestureRecognizer)
    }
    
}

extension ViewThatYouDragOn:Snapable{
    
    var snapThreshold:CGFloat {return 10}
    var viewToSnap: UIView?{return draggingView}
    internal func checkForSnappingGrid(gestureRecognizer: UIPanGestureRecognizer) -> [GuideLine]{
        let draggingPoint = gestureRecognizer.location(in: self)
        
        return lines.filter { line -> Bool in
            if line.axis == .horizontal{
                return abs(draggingPoint.x - line.distance) - snapThreshold < 0
            }else{
                return abs(draggingPoint.y - line.distance) - snapThreshold < 0
            }
        }
        
    }
    
}
