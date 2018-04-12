

extension Snap2meView:Snapable{
    
    public var snapThreshold:CGFloat {return 10}
    public var viewToSnap: UIView?{
        return programmaticDraggingView ?? draggingView
    }
    public func checkForSnappingGrid(gestureRecognizer: UIPanGestureRecognizer) -> [GuideLine]{
        let draggingPoint = gestureRecognizer.location(in: viewToSnap!)
        
        return lines.filter { line -> Bool in
            if line.axis == .horizontal{
                return abs(draggingPoint.x - line.distance) - snapThreshold < 0
            }else{
                return abs(draggingPoint.y - line.distance) - snapThreshold < 0
            }
        }
        
    }
    
}

extension Snap2meView : UIGestureRecognizerDelegate {
    
    func configureGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(panGestureRecognizer)
    }
    
}
open class Snap2meView: UIView {
    @IBOutlet weak var draggingView: UIView!
    public var programmaticDraggingView: UIView? = nil
    
    var lines:Set<GuideLine> = Set<GuideLine>()
    var gridsRendered:Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureGestureRecognizers()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGestureRecognizers()
    }
    
    @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        guard let viewToSnap = viewToSnap else {return}
        switch gestureRecognizer.state {
        case .began:
            
            guard gridsRendered ==  false else {return}
            gridsRendered = true
            lines = GuideLine.create(intersectionPoints: [CGPoint(x: viewToSnap.bounds.midX, y: viewToSnap.bounds.midY)], size: viewToSnap.frame.size)
            lines.forEach{
                viewToSnap.layer.addSublayer($0.layer)
            }
        case .changed:
            let draggingPoint = gestureRecognizer.location(in: superview)
            let lines = checkForSnappingGrid(gestureRecognizer: gestureRecognizer)
            
            if let line = lines.first, lines.count == 1{
                line.layer.opacity = line.layer.visibleOpacity
                self.lines.subtracting(lines).forEach{$0.layer.opacity = 0}
                switch line.axis {
                case .horizontal:
                    self.center.x = line.distance + viewToSnap.frame.origin.x
                    self.center.y = draggingPoint.y
                case .vertical:
                    self.center.y = line.distance + viewToSnap.frame.origin.y
                    self.center.x = draggingPoint.x
                }
                
            }else if lines.count > 1{
                self.center = CGPoint(x: viewToSnap.frame.midX, y: viewToSnap.frame.midY)
                
                for line in lines{
                    line.layer.opacity = line.layer.visibleOpacity
                }
            }else{
                
                self.center = draggingPoint
                
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
