//
//  SearchView.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/30/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class SearchView: UIView{
    
    var onCancel: (() -> ())?
    var onTextChanged: ((String) -> ())?
    
    private let textField = UITextField(placeholder: "Search")
    private let cancelLabel = UILabel(text: "Cancel", font: .black(16), textColor: .black, textAlignment: .center, numberOfLines: 1)
    
    private let textFieldHeight: CGFloat = 30
    
    private var widthCancelConstraint: NSLayoutConstraint?
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupCancel()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        textField.backgroundColor = .init(white: 0.95, alpha: 1)
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        
        let stackView = UIView().hstack(textField.withHeight(textFieldHeight), cancelLabel, spacing: 10, alignment: .center)
        
        addSubview(stackView)
        stackView.fillHorizontally(bothSides: 10)
        stackView.centerYToSuperview()
    }
    
    private func setupCancel() {
        //Setup cancel constraint for animation
        widthCancelConstraint =  cancelLabel.widthAnchor.constraint(equalToConstant: 0)
        widthCancelConstraint?.isActive = true
        
        //Setup cancel label
        cancelLabel.isUserInteractionEnabled = true
        cancelLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancel)))
        cancelLabel.setContentCompressionResistancePriority(.init(rawValue: 999), for: .horizontal)
    }
    
    private func setupTextField() {
        //Setup Textfield
        textField.returnKeyType = .search
        textField.tintColor = .appRose
        textField.roundCorners(radius: 6)
        textField.font = .regular(16)
        
        //Add search icon
        let searchIcon = UIImageView(image: UIImage(named: "Search Icon"), contentMode: .scaleAspectFit)
        let searchView = UIView()
        searchView.addSubview(searchIcon)
        searchIcon.centerInSuperview()
        textField.leftView = searchView.withWidth(30)
            .withHeight(textFieldHeight)
        textField.leftViewMode = .always
        
        //SetupMethods textfield
        textField.delegate = self
        textField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
    }
    
    @objc func handleTextChanged(){
        guard let text = textField.text else {return}
        onTextChanged?(text)
    }
    
    @objc func handleCancel(){
        onCancel?()
    }
}

extension SearchView: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layoutIfNeeded()
        self.widthCancelConstraint?.constant = 60
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseOut, animations: {

            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layoutIfNeeded()
        self.widthCancelConstraint?.constant = 0
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    
}

#if DEBUG
@available(iOS 13, *)
struct SearchViewPreiview: PreviewProvider {
    static var previews: some View {
        SearchView().asPreview()
            .previewLayout(.fixed(width: 300, height: 80
                ))
    }
}
#endif
