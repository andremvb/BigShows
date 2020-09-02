//
//  EpisodesViewModel.swift
//  BigShows
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

protocol EpisodesServiceProtocol{
    func fetchsEpisodes(showID: Int, completion: @escaping (Result<[Episode],Error>) -> ())
}

class EpisodesViewModel{
    
    var episodesViewModel: [EpisodeCellViewModel] = []
    var seasonsViewModel: [Int] = []
    ///Called when fetched new seasons
    var onUpdateSeasons: (() -> ())?
    ///Called when fetched new episodes
    var onUpdateEpisodes: (() -> ())?
    
    
    private let showID: Int
    private let service: EpisodesServiceProtocol
    private var seasons: [Season] = []
    
    
    init(service: EpisodesServiceProtocol, showID: Int){
        self.service = service
        self.showID = showID
    }
    
    func fetchSeasons(){
        service.fetchsEpisodes(showID: showID) { (result) in
            switch result{
            case .success(let episodes):
                self.seasons = self.createSeasons(episodes: episodes)
                self.updateSeasonsViewModel()
                if self.seasons.count > 0{
                    self.updateEpisodes(index: 0)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateEpisodes(index: Int){
        episodesViewModel = seasons[index].episodes.map{EpisodeCellViewModel($0)}
        DispatchQueue.main.async {
            self.onUpdateEpisodes?()
        }
    }
    private func updateSeasonsViewModel(){
        seasonsViewModel = seasons.map{$0.number}
        DispatchQueue.main.async {
            self.onUpdateSeasons?()
        }
    }
    
    private func createSeasons(episodes: [Episode]) -> [Season]{
        
        var seasonsDict: [Int:Season] = [:]
        
        episodes.forEach { (episode) in
            if seasonsDict[episode.season] != nil{
                seasonsDict[episode.season]!.episodes.append(episode)
            }else{
                var season = Season(number: episode.season)
                season.episodes.append(episode)
                seasonsDict[episode.season] = season
            }
        }
        
        var seasons: [Season] = []
        
        //Sort Episodes
        for (_,var season) in seasonsDict{
            season.episodes.sort{$0.number < $1.number}
            seasons.append(season)
        }
        
        //Sort seasons
        seasons.sort{$0.number < $1.number}
        return seasons
    }
}
