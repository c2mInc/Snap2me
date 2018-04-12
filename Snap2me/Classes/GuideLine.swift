public struct GuideLine{
    public enum Axis{
        case vertical
        case horizontal
    }
    public let layer:Snap2meShapeLayer
    public let axis:Axis
    public let distance:CGFloat
    

    public static func create(intersectionPoints:[CGPoint],
                              size:CGSize,
                              lineColor: UIColor = UIColor.blue,
                              shadowColor: UIColor? = UIColor.black) -> Set<GuideLine>{
        
        func createAxisLayer(starts: CGPoint,ends: CGPoint) -> Snap2meShapeLayer{
            let layer = Snap2meShapeLayer()
            layer.opacity = 1
            let path = UIBezierPath()
            path.move(to: starts)
            path.addLine(to: ends)
            path.close()
            layer.path = path.cgPath
            layer.strokeColor = lineColor.cgColor
            layer.lineWidth = 1
            if let shadowColor = shadowColor {
                layer.dropShadow(color: shadowColor, offSet: CGSize.zero)
            }
            return layer
        }
        
        return Set<GuideLine>(intersectionPoints
            .lazy.map({ point -> [GuideLine] in
                let hh = createAxisLayer(starts: CGPoint(x: 0, y: point.y), ends: CGPoint(x: size.width, y: point.y))
                let vv = createAxisLayer(starts: CGPoint(x: point.x, y: 0), ends: CGPoint(x: point.x, y: size.height))
                let h = GuideLine(layer: vv, axis: .horizontal, distance: point.x)
                let v = GuideLine(layer: hh, axis: .vertical, distance: point.y)
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



public class Snap2meShapeLayer : CAShapeLayer{
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
