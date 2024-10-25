//
//  PaddingLabel.swift
//  Movarium
//
//  Created by Anton Solovev on 25.10.2024.
//

import UIKit

class PaddingLabel: UILabel {
    
    var textInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
}
