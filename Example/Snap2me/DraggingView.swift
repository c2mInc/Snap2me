//
//  DraggingView.swift
//  Snap2me_Example
//
//  Created by Erk Ekin on 11.04.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//
import UIKit

public struct GuideLine{
    enum Axis{
        case vertical
        case horizontal
    }
    let layer:Snap2meShapeLayer
    let axis:Axis
    let distance:CGFloat
    
    static func create(intersectionPoints:[CGPoint], size:CGSize) -> Set<GuideLine>{
        
        return Set<GuideLine>(intersectionPoints
            .lazy.map({ point -> [GuideLine] in
                let horizontalLayer = Snap2meShapeLayer()
                horizontalLayer.opacity = 1
                let horizontalPath = UIBezierPath()
                horizontalPath.move(to: CGPoint(x: 0, y: point.y))
                horizontalPath.addLine(to: CGPoint(x: size.width, y: point.y))
                horizontalPath.close()
                horizontalLayer.path = horizontalPath.cgPath
                horizontalLayer.strokeColor = UIColor.blue.cgColor
                horizontalLayer.lineWidth = 1
                horizontalLayer.dropShadow(color: .black, offSet: CGSize.zero)
                
                let verticalLayer = Snap2meShapeLayer()
                let aPath = UIBezierPath()
                aPath.move(to: CGPoint(x: point.x, y: 0))
                aPath.addLine(to: CGPoint(x: point.x, y: size.height))
                aPath.close()
                verticalLayer.path = aPath.cgPath
                verticalLayer.strokeColor = UIColor.blue.cgColor
                verticalLayer.opacity = 1
                verticalLayer.dropShadow(color: .black, offSet: CGSize.zero)
                
                let h = GuideLine(layer: verticalLayer, axis: .horizontal, distance: point.x)
                let v = GuideLine(layer: horizontalLayer, axis: .vertical, distance: point.y)
                return [h, v]
                
            })
            .flatMap { $0 })
    }
}

extension GuideLine: Hashable{
    public var hashValue: Int {
        return Int(distance*100) * (axis == .horizontal ? 1 : -1)
    }
    
    public static func ==(lhs: GuideLine, rhs: GuideLine) -> Bool {
        return lhs.axis == rhs.axis && lhs.layer == rhs.layer
    }
    
}






class Snap2meShapeLayer : CAShapeLayer{
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 4, scale: Bool = true) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = opacity
        shadowOffset = offSet
        shadowRadius = radius
        shouldRasterize = true
        rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

public protocol Snapable{
    var snapThreshold:CGFloat { get }
    var viewToSnap: UIView? { get }
    func checkForSnappingGrid(gestureRecognizer: UIPanGestureRecognizer) -> [GuideLine]
}

class DraggingView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
