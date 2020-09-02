//
//  EpisodesViewController.swift
//  BigShows
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import LBTATools

class EpisodesViewController: UIViewController{
    //Cell ids
    private let seasonID = "seasonID"
    private let episodeID = "episodeID"
    
    //Variables
    private let viewModel: EpisodesViewModel
    private let titleLabel = UILabel(text: "Seasons", font: .black(18), textColor: .black, textAlignment: .center, numberOfLines: 1)
    private var titleStack: UIStackView?
    
    lazy var seasonsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SeasonCell.self, forCellWithReuseIdentifier: seasonID)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var episodesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: episodeID)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    //Functions
    init(viewModel: EpisodesViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {print("-", self, "deinitialized")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindUI()
    }
    
    private func setupView(){
        seasonsCollectionView.backgroundColor = .white
        seasonsCollectionView.contentInset = .init(top: 5, left: 12, bottom: 5, right: 12)
        
        let decoratorLine = UIView(backgroundColor: .appRose).withSize(.init(width: 100, height: 4))
        decoratorLine.roundCorners(radius: 2)
        titleStack = UIStackView(arrangedSubviews: [titleLabel, decoratorLine])
        titleStack?.alignment = .center
        titleStack?.axis = .vertical
        titleStack?.isHidden = true
        let stackView = UIView().stack(titleStack!,
                                       seasonsCollectionView.withHeight(42),
                                       episodesTableView)
        stackView.setCustomSpacing(10, after: titleStack!)
        view.addSubview(stackView)
        stackView.fillSuperviewSafeAreaLayoutGuide()
        
    }
    
    private func bindUI(){
        viewModel.onUpdateSeasons = { [weak self] in
            guard let self = self else {return}
            if self.viewModel.seasonsViewModel.count == 0{
                self.titleStack?.isHidden = true
            }else{
                self.titleStack?.isHidden = false
                self.seasonsCollectionView.reloadData()
                self.seasonsCollectionView.selectItem(at: .init(row: 0, section: 0), animated: true, scrollPosition: .left)
            }
            
        }
        viewModel.onUpdateEpisodes = { [weak self] in
            self?.episodesTableView.reloadData()
        }
        viewModel.fetchSeasons()
    }
}

//Setup Season Collection View
extension EpisodesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.seasonsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: seasonID, for: indexPath) as! SeasonCell
        cell.setupCell(number: viewModel.seasonsViewModel[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.updateEpisodes(index: indexPath.item)
        episodesTableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 56, height: 32)
    }
}

//Setup Episodes TableView
extension EpisodesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.episodesViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: episodeID, for: indexPath) as! EpisodeCell
        cell.setupCell(viewModel.episodesViewModel[indexPath.item])
        return cell
    }
}

#if DEBUG
@available(iOS 13, *)
struct EpisodesViewControllerPreview: PreviewProvider {
    static var previews: some View {
        let viewModel = EpisodesViewModel(service: EpisodesService(), showID: 1)
        viewModel.episodesViewModel = [.fake(),.fake()]
        viewModel.seasonsViewModel = [1,2,3,4]
        return EpisodesViewController(viewModel: viewModel).asPreview()
            .previewDevice(.iphoneXSMax)
    }
}
#endif
