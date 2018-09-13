//
//  VRAdjustmentView.swift
//  TapAndDragTextfield
//
//  Created by Austin Van Alfen on 8/25/18.
//  Copyright © 2018 Austin Van Alfen. All rights reserved.
//

import UIKit

class VRAdjustmentView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let mask = CAShapeLayer()
        mask.frame = self.layer.bounds
        
        let width = self.layer.frame.size.width
        let height = self.layer.frame.size.height
        
        let path = CGMutablePath()
        
        path.move(to: CGPoint.init(x: 0, y: 0))
        path.addLine(to: CGPoint.init(x: width / 2, y: 0))
        path.addLine(to: CGPoint.init(x: width, y: height / 2))
        path.addLine(to: CGPoint.init(x: width / 2, y: height))
        path.addLine(to: CGPoint.init(x: 0, y: height))
        path.addLine(to: CGPoint.init(x: 0, y: 0))
        
        mask.path = path
        
        // CGPathRelease(path); - not needed
        
        self.layer.mask = mask
    }
    

}
