//
//  UIButton + Ex.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit

extension UIButton {
    func configureWith(title: String, fontSize: CGFloat = 16, fontWeight: UIFont.Weight = .regular, color: UIColor = .systemBlue) {
        let titleAttributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize, weight: fontWeight),
            NSAttributedString.Key.foregroundColor : color
        ]
        
        self.setAttributedTitle(NSAttributedString(string: title, attributes: titleAttributes), for: .normal)
        
        
        self.layer.borderColor   = color.cgColor
        self.layer.borderWidth   = 1
        self.layer.cornerRadius  = 10
        self.layer.cornerCurve   = .continuous
    }
}
