//
//  ViewController.swift
//  AnimateBlob
//
//  Created by Sudhanshu Sudhanshu on 04/09/18.
//  Copyright © 2018 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shapeContainerView: UIView!
    var scrollView: UIScrollView!
    var currentPageIndex: CGFloat = 0
    
    var shapeLayer: CAShapeLayer = CAShapeLayer()
    
    var shapes: [Shape] = {
        var arr: [Shape] = [Shape]()
        
        let circle = Shape(frame: CGRect(x: 20, y: 40, width: UIScreen.main.bounds.width, height: 200))
        circle.backgroundColor = .clear
        circle.shape = .blob
        arr.append(circle)
        
        
        let square = Shape(frame: CGRect(x: 20, y: 40, width: UIScreen.main.bounds.width, height: 200))
        square.backgroundColor = .clear
        square.shape = .rectangle
        arr.append(square)
        
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        shapeContainerView = UIView(frame: self.view.frame)
        shapeContainerView.backgroundColor = .green
        view.addSubview(shapeContainerView)
        
        if let shape = shapes.first {
            shapeLayer.path = shape.path.cgPath
            shapeLayer.fillColor = UIColor.orange.cgColor
            shapeContainerView.layer.addSublayer(shapeLayer)
        }
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(triggerAnimation))
        self.view.addGestureRecognizer(tapGR)
        
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.contentSize = CGSize(width: view.bounds.width * 3, height: view.bounds.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        self.view.addSubview(scrollView)
        
    }
    
    @objc func triggerAnimation() {
        animate(from: shapes.first!, to: shapes.last!)
    }
    
    func animate(from initialShape: Shape, to endShape: Shape) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = initialShape.path.cgPath
        animation.toValue = endShape.path.cgPath
        
        animation.duration = 0.5
        
        animation.fillMode = kCAFillModeForwards
        
        animation.isRemovedOnCompletion = false
        
        shapeLayer.add(animation, forKey: "path")
        
        shapes[0] = endShape
        shapes[1] = initialShape
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPageIndex = scrollView.contentOffset.x / view.bounds.width
        print("currentPageIndex: \(currentPageIndex)")
        
        let xMaxOffset = scrollView.contentSize.width - scrollView.bounds.width
        let xCurrentOffset = scrollView.contentOffset.x
        
        let xPercentage = xCurrentOffset / xMaxOffset
        
        didScroll(to : CGPoint(x: xPercentage, y: 0))
    }
    
    func didScroll(to percentage: CGPoint) {
//        let animation = shapeLayer.animation(forKey: "path")
////        animation.paus
//        CATransaction.begin()
//        triggerAnimation()
//        CATransaction.commit()
//        let animation = shapeLayer.animation(forKey: "path")
//        animation?.duration = CFTimeInterval(0.5 * percentage.x)
    }
    
    
}

