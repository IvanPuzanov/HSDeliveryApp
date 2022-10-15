//
//  UILabel + Ex.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit

extension UILabel {
    func configureWith(text: String, fontSize: CGFloat = 16, fontWeight: UIFont.Weight = .regular, textColor: UIColor = .label) {
        self.text       = text
        self.font       = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor  = textColor
    }
}
