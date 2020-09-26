//
//  EntityType.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/16.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation

protocol SearchEntity {
    var entityName: String { get }
}

enum MovieEntity: String, SearchEntity {
    case movieArtist, movie
    
    var entityName: String {
        rawValue
    }
}

enum PodCastEntity: String, SearchEntity {
    case podcastAuthor, podcast
    
    var entityName: String {
        rawValue
    }
}

enum MusicEntity: String, SearchEntity {
    case musicArtist, musicTrack, album, musicVideo, mix, song
    
    var entityName: String {
        rawValue
    }
}

enum MusicVideoEntity: String, SearchEntity {
    
    case musicArtist, musicVideo
    
    var entityName: String {
        rawValue
    }
}

enum AudioBookEntity: String, SearchEntity {
    case audiobookAuthor, audiobook
    
    var entityName: String {
        rawValue
    }
}

enum ShortFilmEntity: String, SearchEntity {
    case shortFilmArtist, shortFilm
    
    var entityName: String {
        rawValue
    }
}

enum TvShowEntity: String, SearchEntity {
    case tvEpisode, tvSeason
    
    var entityName: String {
        rawValue
    }
}

enum SoftwareEntity: String, SearchEntity {
    case software, iPadSoftware, macSoftware
    
    var entityName: String {
        rawValue
    }
}

enum EbookEntity: String, SearchEntity {
    case ebook
    
    var entityName: String {
        rawValue
    }
}

enum AllEntity: String, SearchEntity {
    case movie, album, allArtist, podcast, musicVideo, mix, audiobook, tvSeason, allTrack
    
    var entityName: String {
        rawValue
    }
}


enum MediaType {
    case movie([MovieEntity]), podcast([PodCastEntity]), music([MusicEntity]), musicVideo([MusicVideoEntity]), audiobook([AudioBookEntity]), shortFilm([ShortFilmEntity]), tvShow([TvShowEntity]), software([SoftwareEntity]), ebook([EbookEntity]), all([AllEntity])
    
    var mediaType: String {
        switch self {
        case .movie:
            return "movie"
        case .podcast:
            return "podcast"
        case .music:
            return "music"
        case .musicVideo:
            return "musicVideo"
        case .audiobook:
            return "audiobook"
        case .shortFilm:
            return "shortFilm"
        case .tvShow:
            return "tvShow"
        case .software:
            return "software"
        case .ebook:
            return "ebook"
        case .all:
            return "all"
        }
    }
    
    var entities: [String] {
        switch self {
        case let .movie(entities):
            return entities.map { $0.entityName }
        case let .podcast(entities):
            return entities.map { $0.entityName }
        case let .music(entities):
            return entities.map { $0.entityName }
        case let .musicVideo(entities):
            return entities.map { $0.entityName }
        case let .audiobook(entities):
            return entities.map { $0.entityName }
        case let .shortFilm(entities):
            return entities.map { $0.entityName }
        case let .tvShow(entities):
            return entities.map { $0.entityName }
        case let .software(entities):
            return entities.map { $0.entityName }
        case let .ebook(entities):
            return entities.map { $0.entityName }
        case let .all(entities):
            return entities.map { $0.entityName }
            
        }
    }
}
