//
//public struct GuideLine{
//    enum Axis{
//        case vertical
//        case horizontal
//    }
//    let layer:CAShapeLayer
//    let axis:Axis
//    let distance:CGFloat
//    
//    static func create(intersectionPoints:[CGPoint], size:CGSize) -> Set<GuideLine>{
//        
//        return Set<GuideLine>(intersectionPoints
//            .lazy.map({ point -> [GuideLine] in
//                let horizontalLayer = CAShapeLayer()
//                horizontalLayer.opacity = 1
//                let horizontalPath = UIBezierPath()
//                horizontalPath.move(to: CGPoint(x: 0, y: point.y))
//                horizontalPath.addLine(to: CGPoint(x: size.width, y: point.y))
//                horizontalPath.close()
//                horizontalLayer.path = horizontalPath.cgPath
//                horizontalLayer.strokeColor = UIColor.blue.cgColor
//                horizontalLayer.lineWidth = 5
//                
//                horizontalLayer.dropShadow(color: .yellow, offSet: CGSize.zero)
//                
//                let verticalLayer = CAShapeLayer()
//                let aPath = UIBezierPath()
//                aPath.move(to: CGPoint(x: point.x, y: 0))
//                aPath.addLine(to: CGPoint(x: point.x, y: size.height))
//                aPath.close()
//                verticalLayer.path = aPath.cgPath
//                verticalLayer.strokeColor = UIColor.blue.cgColor
//                verticalLayer.opacity = 1
//                
//                let h = GuideLine(layer: verticalLayer, axis: .horizontal, distance: point.x)
//                let v = GuideLine(layer: horizontalLayer, axis: .vertical, distance: point.y)
//                return [h, v]
//                
//            })
//            .flatMap { $0 })
//    }
//}
//
//extension GuideLine: Hashable{
//    public var hashValue: Int {
//        return Int(distance*100) * (axis == .horizontal ? 1 : -1)
//    }
//    
//    public static func ==(lhs: GuideLine, rhs: GuideLine) -> Bool {
//        return lhs.axis == rhs.axis && lhs.layer == rhs.layer
//    }
//    
//}
