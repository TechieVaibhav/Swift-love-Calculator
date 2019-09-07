//
//  GradientView.swift
//  Calculator
//
//  Created by Vaibhav Sharma on 19/06/19.
//  Copyright © 2019 Vaibhav Sharma. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor : UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var secondColor : UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    override class var layerClass : AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    func updateView()  {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        layer.locations = [0.5]
    }
    
}
