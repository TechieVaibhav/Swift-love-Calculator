//
//  File.swift
//  Calculator
//
//  Created by Vaibhav Sharma on 22/06/19.
//  Copyright © 2019 Vaibhav Sharma. All rights reserved.
//

import Foundation
import UIKit
public class BorderedButton: UIButton {
    
    public override func awakeFromNib() {
        
        let paddingLeftRight: CGFloat = 24.0
        let paddingTopBottom: CGFloat = 16.0
        
        let size = self.titleLabel!.text!.size(
            withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.titleLabel!.font.pointSize)]
        )
        
        self.frame.size = CGSize(width: size.width + paddingLeftRight * 2,
                                 height: size.height + paddingTopBottom * 2)
        
        
        self.contentEdgeInsets = UIEdgeInsets(top: paddingTopBottom,
                                              left: paddingLeftRight,
                                              bottom: paddingTopBottom,
                                              right: paddingLeftRight)
    }
    
    // MARK: Public interface
    
    @IBInspectable public var cornerRadius: CGFloat = 3 {
        didSet {
            self.clipsToBounds = true
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var bgColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    // MARK: Overrides
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutRoundRectLayer()
    }
    
    override public var isEnabled: Bool {
        didSet {
            layoutSubviews()
        }
    }
    
    // MARK: Private
    
    private var roundRectLayer: CAShapeLayer?
    
    private func layoutRoundRectLayer() {
        if let existingLayer = roundRectLayer {
            existingLayer.removeFromSuperlayer()
        }
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        shapeLayer.fillColor = bgColor.cgColor
        
        if self.isEnabled {
            shapeLayer.strokeColor = borderColor.cgColor
        } else {
            shapeLayer.strokeColor = UIColor.gray.cgColor
        }
        
        
        self.layer.insertSublayer(shapeLayer, at: 0)
        self.roundRectLayer = shapeLayer
        self.layer.masksToBounds = false
        self.clipsToBounds  = true
    }
}
