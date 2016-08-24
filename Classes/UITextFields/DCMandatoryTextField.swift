//
//  BorderedTextField.swift
//  DCKit
//
//  Created by Andrey Gordeev on 16/02/15.
//  Copyright (c) 2015 Andrey Gordeev (andrew8712@gmail.com). All rights reserved.
//

import UIKit

/// Highlights the text field if the entered value is false.
@IBDesignable
open class DCMandatoryTextField: DCBorderedTextField {
    
    override open var isSelected: Bool {
        didSet {
            updateColor()
        }
    }
   
    @IBInspectable
    open var highlightedBorderColor: UIColor = UIColor.red {
        didSet {
            updateColor()
        }
    }
    
    @IBInspectable
    open var isMandatory: Bool = true
    
    // MARK: - Build control
    
    override open func customInit() {
        super.customInit()
        
        updateColor()
        let _ = isValid()
        self.addTarget(self, action: #selector(DCMandatoryTextField.isValid), for: UIControlEvents.editingChanged)
    }
    
    // MARK: - Initializers
    
    // IBDesignables require both of these inits, otherwise we'll get an error: IBDesignable View Rendering times out.
    // http://stackoverflow.com/questions/26772729/ibdesignable-view-rendering-times-out
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Build control
    
    override open func configurePlaceholder() {
        
    }
    
    // MARK: - Validation
    
    /// Checks if the field's value is valid. Can be overriden by subclasses.
    ///
    /// :return: True, if the field is mandatory and value is not empty.
    open func isValid() -> Bool {
        if isMandatory {
            let valid = !(text ?? "").isEmpty
            isSelected = !valid
            return valid
        }
        else {
            return true
        }
    }
    
    // MARK: - Misc
    
    func updateColor() {
        layer.borderColor = isSelected ? highlightedBorderColor.cgColor : normalBorderColor.cgColor
    }
    
}
