//
//  SwiftUIViewBinding.swift
//  GOX
//
//  Created by Andre Valdivia on 5/22/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import SwiftUI

#if DEBUG
@available(iOS 13.0.0, *)
class SwiftUIViewBinding<MyViewController: UIViewController>{
    
    let myViewController: MyViewController
    
    init(_ vc: MyViewController){
        self.myViewController = vc
    }
    
    struct Integrated: UIViewControllerRepresentable{
        
        let myViewController: MyViewController
        
        func updateUIViewController(_ uiViewController: MyViewController, context: UIViewControllerRepresentableContext<SwiftUIViewBinding<MyViewController>.Integrated>) {

        }

        typealias UIViewControllerType = MyViewController

        func makeUIViewController(context: UIViewControllerRepresentableContext<SwiftUIViewBinding.Integrated>) -> SwiftUIViewBinding.Integrated.UIViewControllerType {
            return myViewController
        }
    }

    struct SwiftUIView: View{
        let myViewController: MyViewController
        var body: some View{
            Integrated(myViewController: self.myViewController).edgesIgnoringSafeArea(.all)
        }
    }
    
    lazy var view = SwiftUIView(myViewController: myViewController)
}
#endif
