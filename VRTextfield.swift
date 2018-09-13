//
//  VRTextfield.swift
//  TapAndDragTextfield
//
//  Created by Austin Van Alfen on 8/25/18.
//  Copyright © 2018 Austin Van Alfen. All rights reserved.
//

import UIKit

class VRTextfield: UITextField {
    
    private var originPoint: CGPoint = CGPoint()
    private var valueView: UIView = UIView()
    private var newValue: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(addValueView(_:)))
        gesture.maximumNumberOfTouches = 1
        gesture.minimumNumberOfTouches = 1
        
        self.addGestureRecognizer(gesture)
        
        self.text = "50"
    }
    
    @objc private func addValueView(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .ended {
            self.text = "\(self.newValue)"
            UIView.animate(withDuration: 0.5, animations: {
                self.valueView.alpha = 0
            }) { (_) in
                self.valueView.removeFromSuperview()
            }
            return
        }
        
        self.originPoint = gesture.location(in: self.superview)
        
        valueView.removeFromSuperview()

        let view = setupValueView(with: getNewTextfieldValue())

        self.superview?.addSubview(view)

        valueView = view
    }
    
    private func setupValueView(with text: String) -> UIView {
        let view = VRAdjustmentView(frame: CGRect.init(x: self.center.x - 75, y: originPoint.y - 25, width: 75, height: 50))
        
        view.backgroundColor = .lightGray
        
        let label = UILabel(frame: CGRect.init(x: 5, y: 5, width: 30, height: 40))
        label.textColor = .black
        label.backgroundColor = .white
        label.text = text
        
        view.addSubview(label)
        
        return view
    }
    
    private func getNewTextfieldValue() -> String {
        guard let value = Int(self.text!) else {
            print("error")
            return "error"
        }
        
        let distance = Int(self.center.y - self.originPoint.y)
        
        let valueToAdd = distance / 5
        
        let newValue = value + valueToAdd
        
        self.newValue = newValue
        
        return "\(newValue)"
    }
    
}
