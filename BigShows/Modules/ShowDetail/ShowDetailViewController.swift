//
//  ShowDetailViewController.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/31/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class MyNavigationBar: UIView{
    
}

class ShowDetailViewController: UIViewController{
    
    private let viewModel: ShowDetailViewModel
    private let episodesViewController: EpisodesViewController?
    
    //Views
    private let portraitImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    private let textsView = TextsView()
    
    
    init(viewModel: ShowDetailViewModel, episodesViewController: EpisodesViewController?){
        self.viewModel = viewModel
        self.episodesViewController = episodesViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateUI()
        bindUI()
        
    }
        
    private func setupView(){
        view.backgroundColor = .white
        setupNavigation()

        //Compose detail section
        portraitImageView.translatesAutoresizingMaskIntoConstraints = false
        portraitImageView.heightAnchor.constraint(equalTo: portraitImageView.widthAnchor, multiplier: 234 / 167).isActive = true
        portraitImageView.backgroundColor = .init(white: 0.9, alpha: 1)
        portraitImageView.roundCorners(radius: 20)
        portraitImageView.withWidth(160)
        let detailSectionView = UIView().hstack(UIView().stack(portraitImageView, UIView()),
                                      textsView,
                                      spacing: 10).withMargins(.allSides(15))
        textsView.translatesAutoresizingMaskIntoConstraints = false
        textsView.heightAnchor.constraint(equalTo: portraitImageView.heightAnchor, multiplier: 1.2).isActive = true
        
        //Compose episodeSection
        let episodesSectionView = UIView()
        if let episodesViewController = episodesViewController{
            addChild(episodesViewController)
            episodesSectionView.addSubview(episodesViewController.view)
            episodesViewController.view.fillSuperview()
        }
        
        //Compose two sections
        let stackView = UIView().stack(detailSectionView, episodesSectionView, spacing: 10)
        view.addSubview(stackView)
        stackView.fillSuperviewSafeAreaLayoutGuide()
    }
    
    private func setupNavigation(){
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().backgroundColor = UIColor.white
        UINavigationBar.appearance().shadowImage = UIImage()
        let logoView = UIImageView(image: UIImage(named: "Logo")?.withRenderingMode(.alwaysTemplate), contentMode: .scaleAspectFit).withHeight(25)
        navigationItem.titleView = logoView
    }
    
    private func updateUI(){
        //Setup with temporal
        portraitImageView.loadImageWithUrl(urlString: viewModel.image?.medium, nameDefault: "Port Default")
        textsView.fillView(name: viewModel.name,
                           summary: viewModel.summary,
                           days: viewModel.days,
                           genres: viewModel.genres)
    }
    
    private func bindUI(){
        viewModel.fetchShowDetail()
        viewModel.updateDetails = { [weak self] in
            self?.updateUI()
        }
    }
}

#if DEBUG
@available(iOS 13, *)
struct ShowDetailPreview: PreviewProvider {
    static var previews: some View {
        let viewmodel = ShowDetailViewModel(service: ShowsService(), showPreview: .fake())
        
        return ShowDetailViewController(viewModel: viewmodel, episodesViewController: nil).asPreview()
            .previewDevice(.iphoneXSMax)
    }
}
#endif
