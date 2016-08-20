//
//  CustomImageView.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation
import UIKit

class CustomImageView : UIImageView {
    
    var lowerLayerShadow:CALayer!
    var upperLayerShadow:CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawShadow()
        drawLowerShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawShadow()
        drawLowerShadow()
    }
    
    func drawShadow() {
        
        if upperLayerShadow == nil {
        
        let size = self.frame.size
        self.clipsToBounds = true
        let layer: CALayer = CALayer()
        layer.backgroundColor = UIColor.blackColor().CGColor
        layer.position = CGPointMake(size.width / 2, -size.height / 2)
        layer.bounds = CGRectMake(0, 0, size.width, size.height)
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(0.5, size.height * 0.20)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5.0
        upperLayerShadow = layer
            
        self.layer.addSublayer(layer)
        }
        
    }
    
    func drawLowerShadow() {
        
        if lowerLayerShadow == nil {
        
        let size = self.frame.size
        self.clipsToBounds = true
        let layer: CALayer = CALayer()
        layer.backgroundColor = UIColor.blackColor().CGColor
        layer.position = CGPointMake(size.width / 2, size.height + size.height / 2 )
        layer.bounds = CGRectMake(0, 0, size.width, size.height)
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(0.5, -size.height * 0.40)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5.0
        lowerLayerShadow = layer
            
        self.layer.addSublayer(layer)
            
        }
        
        
    }
    
}