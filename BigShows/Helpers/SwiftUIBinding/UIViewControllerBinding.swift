//
//  UIViewControllerBinding.swift
//  GOX
//
//  Created by Andre Valdivia on 6/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

@available(iOS 13, *)
extension UIViewController {
    
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

    func asPreview() -> some View {
        Preview(viewController: self)
    }
}
