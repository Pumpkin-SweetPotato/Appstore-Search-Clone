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

enum MovieEntity: SearchEntity {
    case movieArtist, movie
    
    var entityName: String {
        switch self {
        case .movieArtist:
            return "movieArtist"
        case .movie:
            return "movie"
        }
    }
}

enum PodCastEntity: SearchEntity {
    case podcastAuthor, podcast
    
    var entityName: String {
        switch self {
        case .podcast:
            return "podcast"
        case .podcastAuthor:
            return "podcastAuthor"
        }
    }
}

enum MusicEntity: SearchEntity {
    case musicArtist, musicTrack, album, musicVideo, mix, song
    
    var entityName: String {
        switch self {
        case .musicTrack:
            return "musicTrack"
        case .musicArtist:
            return "musicArtist"
        case .album:
            return "album"
        case .musicVideo:
            return "musicVideo"
        case .mix:
            return "mix"
        case .song:
            return "song"
        }
    }
}

enum MusicVideoEntity: SearchEntity {
    
    case musicArtist, musicVideo
    
    var entityName: String {
        switch self {
        case .musicVideo:
            return "musicVideo"
        case .musicArtist:
            return "musicArtist"
        }
    }
}

enum AudioBookEntity: SearchEntity {
    case audiobookAuthor, audiobook
    
    var entityName: String {
        switch self {
        case .audiobookAuthor:
            return "audiobookAuthor"
        case .audiobook:
            return "audiobook"
        }
    }
}

enum ShortFilmEntity: SearchEntity {
    case shortFilmArtist, shortFilm
    
    var entityName: String {
        switch self {
        case .shortFilm:
            return "shorFilem"
        case .shortFilmArtist:
            return "shortFilmArtist"
        }
    }
}

enum TvShowEntity: SearchEntity {
    case tvEpisode, tvSeason
    
    var entityName: String {
        switch self {
        case .tvSeason:
            return "tvSeason"
        case .tvEpisode:
            return "tvEpisode"
        }
    }
}

enum SoftwareEntity: SearchEntity {
    case software, iPadSoftware, macSoftware
    
    var entityName: String {
        switch self {
        case .software:
            return "software"
        case .iPadSoftware:
            return "iPadSoftware"
        case .macSoftware:
            return "makSoftware"
        }
    }
}

enum EbookEntity: SearchEntity {
    case ebook
    
    var entityName: String {
        switch self {
        case .ebook:
            return "ebook"
        }
    }
}

enum AllEntity: SearchEntity {
    case movie, album, allArtist, podcast, musicVideo, mix, audiobook, tvSeason, allTrack
    
    var entityName: String {
        switch self {
        case .movie:
            return "movie"
        case .album:
            return "album"
        case .allArtist:
            return "allArtist"
        case .podcast:
            return "podcase"
        case .musicVideo:
            return "musicVideo"
        case .mix:
            return "mix"
        case .audiobook:
            return "audiobook"
        case .tvSeason:
            return "tvSeason"
        case .allTrack:
            return "allTrack"
        }
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
