public struct GuideLine{
    
    public enum Axis{
        case vertical
        case horizontal
    }
    public let layer:Snap2meShapeLayer
    public let axis:Axis
    public let distance:CGFloat
    
    public struct AxisPercentage {
        let axis:Axis
        let percentage:CGFloat
        public init(axis: Axis, percentage: CGFloat) {
            self.axis = axis
            self.percentage = percentage
        }
    }
    
    public struct Settings{
        let lineColor: UIColor
        let lineWidth: CGFloat
        let shadowColor: UIColor?
        let flushesInitially: Bool
        let threshold: CGFloat
        
        public init(lineColor: UIColor = UIColor.blue, lineWidth: CGFloat = 1, shadowColor: UIColor = UIColor.black, flushesInitially:Bool = false, threshold:CGFloat = 15){
            self.lineColor = lineColor
            self.lineWidth = lineWidth
            self.shadowColor = shadowColor
            self.flushesInitially = flushesInitially
            self.threshold = threshold
        }
   
    }
    
    public static func create(axisPercentages:[AxisPercentage],
                              size: CGSize,
                              settings: Settings? = nil) -> Set<GuideLine>{
        let settings = settings ?? Settings()
        
        func createAxisLayer(starts: CGPoint,ends: CGPoint) -> Snap2meShapeLayer{
            let layer = Snap2meShapeLayer()
            layer.opacity = settings.flushesInitially ? layer.visibleOpacity : 0 
            let path = UIBezierPath()
            path.move(to: starts)
            path.addLine(to: ends)
            path.close()
            layer.path = path.cgPath
            layer.strokeColor = settings.lineColor.cgColor
            layer.lineWidth = settings.lineWidth
            if let shadowColor = settings.shadowColor {
                layer.dropShadow(color: shadowColor, offSet: CGSize.zero)
            }
            return layer
        }
        
        return Set<GuideLine>(axisPercentages
            .lazy.map({ axisPercentage -> [GuideLine] in
                let distancey = size.height * axisPercentage.percentage
                let distancex = size.width * axisPercentage.percentage
                switch axisPercentage.axis{
                case .horizontal:
                    return [
                        GuideLine(layer: createAxisLayer(starts: CGPoint(x: distancex, y: 0), ends: CGPoint(x: distancex, y: size.height)),
                                  axis: .horizontal,
                                  distance: distancex)
                    ]
                case .vertical:
                    return [
                        GuideLine(layer: createAxisLayer(starts: CGPoint(x: 0, y: distancey), ends: CGPoint(x: size.width, y: distancey)),
                                  axis: .vertical,
                                  distance: distancey)
                    ]
                }
                
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
    var visibleOpacity :Float = 0.3
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
