//
//  TextsView.swift
//  BigShows
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import LBTATools

class TextsView: UIView{
    let titleLabel = UILabel(text: nil, font: .black(20), textColor: .black, numberOfLines: 0)
    let summaryLabel = UILabel(text: nil, font: .regular(), textColor: .darkGray, numberOfLines: 0)
    let daysLabel = UILabel(text: nil, font: .bold(12), textColor: .darkGray, numberOfLines: 0)
    let genresLabel = UILabel(text: nil, font: .regular(12), textColor: .gray, numberOfLines: 0)
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    init(){
        super.init(frame: .zero)
        setupScrollAndStack()
        setupView()
    }
    
    func setupScrollAndStack(){
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(stackView)
        stackView.fillSuperview()
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.axis = .vertical
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        [titleLabel, daysLabel, genresLabel, summaryLabel].forEach{
            stackView.addArrangedSubview($0)
        }
        let gradientView = WhiteGradientView()
        addSubview(gradientView)
        gradientView.anchor(.leading(leadingAnchor),
                            .trailing(trailingAnchor),
                            .bottom(bottomAnchor),
                            .height(80))
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    func fillView(name: String?, summary: String?, days: String?, genres: String?){
        titleLabel.text = name
        genresLabel.text = genres
        daysLabel.text = days
        summaryLabel.text = summary
    }
}
