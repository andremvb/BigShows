//
//  ShowOnBoardingView.swift
//  BigShows
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class ShowOnBoardingView: UIView{
    private let imageView = UIImageView(image: UIImage(named: "Logo")?.withRenderingMode(.alwaysTemplate), contentMode: .scaleAspectFit)
    private let label = UILabel(text: "Please, search for \n some shows!", font: .bold(), textColor: .init(white: 0.9, alpha: 1), textAlignment: .center, numberOfLines: 2)
    
    init(){
        super.init(frame: .zero)
        let stackView = UIView().stack(label, imageView, spacing: 15)
        imageView.tintColor = .init(white: 0.9, alpha: 1)
        addSubview(stackView)
        stackView.centerInSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if DEBUG
@available(iOS 13, *)
struct ShowOnBoardingViewPreview: PreviewProvider {
    static var previews: some View {
        ShowOnBoardingView().asPreview()
            .previewDevice(.iphoneXSMax)
    }
}
#endif
