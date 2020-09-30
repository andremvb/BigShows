//
//  ShowsViewController.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/29/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class ShowsViewController: UIViewController{
    
    enum ViewState{
        case onboarding, data
    }
    
    private let showsViewModel: ShowsViewModel
    private let cellSpacing: CGFloat = 10
    var state: ViewState = .onboarding
    
    //UIComponents
    let searchBar = SearchView()
    let cellID = "cellID"
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ShowPreviewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    //Init
    init(showsViewModel: ShowsViewModel){
        self.showsViewModel = showsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupView(){
        view.backgroundColor = .white
        navigationItem.title = " "
        
        let mainView = UIView()
        let onBoarding = ShowOnBoardingView()
        mainView.addSubview(onBoarding)
        onBoarding.centerInSuperview()
        
        mainView.addSubview(collectionView)
        collectionView.fillSuperview()
        
        let stackView = UIView().stack(searchBar.withHeight(70), mainView)
        view.addSubview(stackView)
        stackView.fillSuperviewSafeAreaLayoutGuide()
        collectionView.backgroundColor = .white
        collectionView.contentInset = .allSides(cellSpacing)
        
        //Setup initial state
        changeState(.onboarding)
    }
    
    private func bindUI(){
        searchBar.onCancel = {
            self.view.endEditing(true)
        }
        searchBar.onTextChanged = { text in
            self.showsViewModel.fetchShows(text)
        }
        
        showsViewModel.didUpdate = { [weak self] in
            guard let self = self else {return}
            if self.showsViewModel.showsViewModel.count == 0 {
                self.changeState(.onboarding)
            }else{
                self.changeState(.data)
            }
        }
    }
    
    private func changeState(_ state: ViewState){
        DispatchQueue.main.async {
            switch state{
            case .onboarding:
                self.collectionView.isHidden = true
            case .data:
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetchShows(_ query: String){
        showsViewModel.fetchShows(query)
    }
}

extension ShowsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showsViewModel.showsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ShowPreviewCell
        cell.showPreview = showsViewModel.showsViewModel[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showsViewModel.tapedShow(index: indexPath.item)
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - cellSpacing * 3) / 2
//        return .init(width: width, height: width * 234 / 167)
        return .init(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }
    
}

#if DEBUG
@available(iOS 13, *)
struct ShowsVCPreview: PreviewProvider {
    static var previews: some View {
        
        let viewModel = ShowsViewModel(loader: { (query, result) in
            
        }, navigate: { showPreview in

        })
        
        viewModel.showsViewModel = [.fake(), .fake(), .fake()]
        
        return ShowsViewController(showsViewModel: viewModel).asPreview()
            .previewDevice(.iphoneXSMax)
    }
}
#endif
