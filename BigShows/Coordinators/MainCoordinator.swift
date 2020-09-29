//
//  MainCoordinator.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/30/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator{
    let navigationController: UINavigationController
    let service = ShowsService()
    
    init(navigationController: UINavigationController = UINavigationController()){
        self.navigationController = navigationController
        let showsViewController = createShowsVC()
        navigationController.pushViewController(showsViewController, animated: true)
    }
    
    func start(window: UIWindow){
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension MainCoordinator: ShowsNavigator {
    func goToShowDetail(_ show: ShowPreview) {
        let episodesVC = createEpisodesVC(showID: show.id)
        let service = ShowsService()
        let viewModel = ShowDetailViewModel(service: service, showPreview: show)
        let showsDetailViewController = ShowDetailViewController(viewModel: viewModel,
                                                                 episodesViewController: episodesVC)
        
        navigationController.pushViewController(showsDetailViewController, animated: true)
    }
}

//Factory-like methods
extension MainCoordinator {
    private func createEpisodesVC(showID: Int) -> EpisodesViewController{
        let service = EpisodesService()
        let viewmodel = EpisodesViewModel(service: service, showID: showID)
        let viewController = EpisodesViewController(viewModel: viewmodel)
        return viewController
    }
    
    private func createShowsVC() -> ShowsViewController{
        let loader: ShowsViewModel.ShowsLoader = service.fetchShows

        let viewModel = ShowsViewModel(loader: loader) { [weak self](showPreview) in
            self?.goToShowDetail(showPreview)
        }
        return ShowsViewController(showsViewModel: viewModel)
    }
}
