//
//  UIView.swift
//  GOX
//
//  Created by Andre Valdivia on 5/26/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit

extension CGSize{
    static func squared(_ size: CGFloat) -> CGSize{
        CGSize(width: size, height: size)
    }
}

extension UIView {
    
    func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor,
                                UIColor.init(white: 1, alpha: 0).cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 160, height: 160)

        layer.addSublayer(gradientLayer)
        
    }
    
    func border(width: CGFloat, color: UIColor) -> Self{
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }
    
    func roundCorners(radius: CGFloat, corners: CACornerMask? = nil){
        if let corners = corners{
            layer.maskedCorners = corners
        }
        layer.cornerRadius = radius
    }
    
    func squared(){
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    func addFilledSafe(_ view: UIView, padding: UIEdgeInsets = .zero){
        addSubview(view)
        view.fillSuperviewSafeAreaLayoutGuide(padding: padding)
    }
    
    func addFilled(_ view: UIView, padding: UIEdgeInsets = .zero){
        addSubview(view)
        view.fillSuperview(padding: padding)
    }
    
    func tapDismiss(){
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    func panDismiss(){
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    @objc func handleDismiss(){
        endEditing(true)
    }
    
    @discardableResult
    func fillHorizontally(leftPadding: CGFloat = 0, rightPadding: CGFloat = 0) -> UIView{
        guard let superview = superview else {return self}
        anchor(.leading(superview.leadingAnchor, constant: leftPadding),
               .trailing(superview.trailingAnchor, constant: rightPadding))
        return self
    }
    
    @discardableResult
    func fillHorizontally(bothSides: CGFloat = 0) -> UIView{
        guard let superview = superview else {return self}
        anchor(.leading(superview.leadingAnchor, constant: bothSides),
               .trailing(superview.trailingAnchor, constant: bothSides))
        return self
    }
}
