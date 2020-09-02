//
//  UIViewBinding.swift
//  GOX
//
//  Created by Andre Valdivia on 6/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import LBTATools

#if DEBUG
extension UIView{
    @available(iOS 13, *)
        private struct Preview: UIViewControllerRepresentable {
        var viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController,
                                    context: Context) {
            // No-op
        }
    }

    @available(iOS 13, *)
    func asPreview(_ backgroundColor: UIColor = .white) -> some View {
        let viewController = UIViewController()
        viewController.view.addSubview(self)
        viewController.view.backgroundColor = backgroundColor
        self.fillSuperview()
        return Preview(viewController: viewController)
    }
}
#endif
