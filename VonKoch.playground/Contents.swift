import UIKit
import PlaygroundSupport

class DrawingView: UIView {
    
    var numberOfIterations: Int
    
    override init(frame: CGRect) {
        numberOfIterations = 10
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        numberOfIterations = 10
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let x = rect.midX + 25
        let y = rect.midY + 10
        
        let sideLength = min(rect.width, rect.height) / 2 - 40
        let a = CGPoint(x: x - sideLength / 2, y: y + sqrt(3) * sideLength / 6 - sideLength / 3)
        let b = CGPoint(x: x + sideLength / 2, y: y + sqrt(3) * sideLength / 6 - sideLength / 3)
        let c = CGPoint(x: x, y: y - sqrt(3) * sideLength / 3 - sideLength / 3)
        
        koch(numberOfIterations, a: a, b: b)
        koch(numberOfIterations, a: b, b: c)
        koch(numberOfIterations, a: c, b: a)
    }
    
    func koch(_ n: Int, a: CGPoint, b: CGPoint) {
        if n == 0 {
            let path = UIBezierPath()
            path.move(to: a)
            path.addLine(to: b)
            path.lineWidth = 1.0
            UIColor.black.setStroke()
            path.stroke()
        } else {
            let p = CGPoint(x: (2*a.x + b.x)/3, y: (2*a.y + b.y)/3)
            let q = CGPoint(x: (a.x + b.x)/2 - sqrt(3)*(b.y - a.y)/6, y: (a.y + b.y)/2 - sqrt(3)*(a.x - b.x)/6)
            let r = CGPoint(x: (a.x + 2*b.x)/3, y: (a.y + 2*b.y)/3)
            
            koch(n-1, a: a, b: p)
            koch(n-1, a: p, b: q)
            koch(n-1, a: q, b: r)
            koch(n-1, a: r, b: b)
        }
    }
    
}

let view = DrawingView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
view.backgroundColor = UIColor.white
view.numberOfIterations = 3 // Change the number of iterations here

PlaygroundPage.current.liveView = view
