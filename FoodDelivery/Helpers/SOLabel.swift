//
//  SOLabel.swift
//  FoodDelivery
//
//  Created by Anton on 07.07.23.
//

import UIKit

enum VerticalAlignment {
    case top
    case middle
    case bottom
}

class SOLabel: UILabel {
    
    var verticalAlignment: VerticalAlignment = .top {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawText(in rect: CGRect) {
        var adjustedRect = rect
        let size = super.sizeThatFits(rect.size)
        
        switch verticalAlignment {
        case .top:
            adjustedRect.size.height = size.height
        case .middle:
            adjustedRect.origin.y += (adjustedRect.size.height - size.height) / 2
            adjustedRect.size.height = size.height
        case .bottom:
            adjustedRect.origin.y += adjustedRect.size.height - size.height
            adjustedRect.size.height = size.height
        }
        
        super.drawText(in: adjustedRect)
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        
        switch verticalAlignment {
        case .top:
            textRect.origin.y = bounds.origin.y
        case .middle:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2
        case .bottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height
        }
        
        return textRect
    }
    
}

