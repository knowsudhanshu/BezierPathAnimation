//
//  Shape.swift
//  AnimateBlob
//
//  Created by Sudhanshu Sudhanshu on 04/09/18.
//  Copyright © 2018 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

enum ShapeType {
    case circle, square, rectangle, triangle, blob
}
class Shape: UIView {

    var path : UIBezierPath!
    
    private var shapeValue: ShapeType!
    var shape: ShapeType {
        set{
            shapeValue = newValue
            drawShape(newValue)
        }
        get {
            return shapeValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
//        drawShape(.circle)
    }
    
    
    func drawShape(_ shape: ShapeType) {
        path = bezierPath(shape)
//        UIColor.orange.setFill()
//        path.fill()
    }
    
    private func bezierPath(_ shape: ShapeType) -> UIBezierPath? {
        switch shape {
        case .circle:
            return UIBezierPath(ovalIn: self.bounds)
        case .rectangle:
            return UIBezierPath(rect: self.bounds)
        case .blob:
            
            let oneThirdWidth = self.bounds.width / 3
            let oneThirdHeight = self.bounds.height / 3
            
            let blobPath = UIBezierPath()
            blobPath.move(to: CGPoint.zero)
            
            blobPath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
            
            blobPath.addCurve(to: CGPoint(x: oneThirdWidth, y: self.bounds.height), controlPoint1: CGPoint(x: oneThirdWidth / 3, y: oneThirdHeight * 2), controlPoint2: CGPoint(x: 2 * oneThirdWidth / 3, y: oneThirdHeight * 2))
            
            
            blobPath.addCurve(to: CGPoint(x: 2 * oneThirdWidth, y: self.bounds.height), controlPoint1: CGPoint(x: oneThirdWidth + (oneThirdWidth / 3), y: self.bounds.height + oneThirdHeight), controlPoint2: CGPoint(x: (oneThirdWidth * 2) - (oneThirdWidth / 3), y: self.bounds.height))
            
            
            blobPath.addCurve(to: CGPoint(x: self.bounds.width, y: self.bounds.height), controlPoint1: CGPoint(x: (2 * oneThirdWidth) + (oneThirdWidth / 3), y: oneThirdHeight * 3), controlPoint2: CGPoint(x: self.bounds.width, y: self.bounds.height))
            
            blobPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
            
            blobPath.close()
            return blobPath
            
            
        default:
            return nil
        }
    }
}
