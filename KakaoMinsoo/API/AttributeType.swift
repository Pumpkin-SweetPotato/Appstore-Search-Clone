//
//  AttributeType.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/16.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation

protocol AttributeType {
    var attributeName: String { get }
}

enum MovieAttirubte: AttributeType {
    case actorTerm, genreIndex, artistTerm, shortFilmTerm, producerTerm, ratingTerm, directorTerm, releaseYearTerm, featureFilmTerm, movieArtistTerm, movieTerm, ratingIndex, descriptionTerm
    
    var attributeName: String {
        switch self {
            
        case .actorTerm:
            return "actorTerm"
        case .genreIndex:
            return "genreIndex"
        case .artistTerm:
            return "artistTerm"
        case .shortFilmTerm:
            return "shortFilmTerm"
        case .producerTerm:
            return "producerTerm"
        case .ratingTerm:
            return "ratingTerm"
        case .directorTerm:
            return "directorTerm"
        case .releaseYearTerm:
            return "releaseYearTerm"
        case .featureFilmTerm:
            return "featureFilmTerm"
        case .movieArtistTerm:
            return "movieArtistTerm"
        case .movieTerm:
            return "movieTerm"
        case .ratingIndex:
            return "ratingIndex"
        case .descriptionTerm:
            return "descriptionTerm"
        }
    }
}

enum PodcaseAttriute: AttributeType {
    case titleTerm, languageTerm, authorTerm, genreIndex, artistTerm, ratingIndex, keywordsTerm, descriptionTerm
    
    var attributeName: String {
        switch self {
            
        case .titleTerm:
            return "titleTerm"
        case .languageTerm:
            return "languageTerm"
        case .authorTerm:
            return "authorTerm"
        case .genreIndex:
            return "genreIndex"
        case .artistTerm:
            return "artistTerm"
        case .ratingIndex:
            return "ratingIndex"
        case .keywordsTerm:
            return "keywordsTerm"
        case .descriptionTerm:
            return "descriptionTerm"
        }
    }
}

enum MusicAttribute: AttributeType {
    
    case mixTerm, genreIndex, artistTerm, composerTerm, albumTerm, ratingIndex, songTerm
    
    var attributeName: String {
        switch self {
            
        case .mixTerm:
            return "mixTerm"
        case .genreIndex:
            return "genreIndex"
        case .artistTerm:
            return "artistTerm"
        case .composerTerm:
            return "composerTerm"
        case .albumTerm:
            return "albumTerm"
        case .ratingIndex:
            return "ratingIndex"
        case .songTerm:
            return "songTerm"
        }
    }
}

enum MusicVideo: AttributeType {
    
    case genreIndex, artistTerm, albumTerm, ratingIndex, songTerm
    
    var attributeName: String {
        switch self {
            
        case .genreIndex:
            return "genreIndex"
        case .artistTerm:
            return "artistTerm"
        case .albumTerm:
            return "albumTerm"
        case .ratingIndex:
            return "ratingIndex"
        case .songTerm:
            return "songTerm"
        }
    }
}

enum AudioBookAttribute: AttributeType {
    
    case titleTerm, authorTerm, genreIndex, ratingIndex
    
    var attributeName: String {
        switch self {
            
        case .titleTerm:
            return "titleTerm"
        case .authorTerm:
            return "authorTerm"
        case .genreIndex:
            return "genreIndex"
        case .ratingIndex:
            return "ratingIndex"
        }
    }
}

enum ShortFile: AttributeType {
    
    case genreIndex, artistTerm, shortFilmTerm, ratingIndex, descriptionTerm
    
    var attributeName: String {
        switch self {
            
        case .genreIndex:
            return "genreIndex"
        case .artistTerm:
            return "artistTerm"
        case .shortFilmTerm:
            return "shortFilmTerm"
        case .ratingIndex:
            return "ratingIndex"
        case .descriptionTerm:
            return "descriptionTerm"
        }
    }
}

enum SoftwareAttribute: AttributeType {

    case softwareDeveloper
    
    var attributeName: String {
        switch self {
            
        case .softwareDeveloper:
            return "softwareDeveloper"
        }
    }
}

enum TvShowAttribute: AttributeType {
    
    case genreIndex, tvEpisodeTerm, showTerm, tvSeasonTerm, ratingIndex, descriptionTerm
    
    var attributeName: String {
        switch self {
            
        case .genreIndex:
            return "genreIndex"
        case .tvEpisodeTerm:
            return "tvEpisodeTerm"
        case .showTerm:
            return "showTerm"
        case .tvSeasonTerm:
            return "tvSeasonTerm"
        case .ratingIndex:
            return "ratingIndex"
        case .descriptionTerm:
            return "descriptionTerm"
        }
    }
}

enum AllAttribute: AttributeType {
    case actorTerm, languageTerm, allArtistTerm, tvEpisodeTerm, shortFilmTerm, directorTerm, releaseYearTerm, titleTerm, featureFilmTerm, ratingIndex, keywordsTerm, descriptionTerm, authorTerm, genreIndex, mixTerm, allTrackTerm, artistTerm, composerTerm, tvSeasonTerm, producerTerm, ratingTerm, songTerm, movieArtistTerm, showTerm, movieTerm, albumTerm
    
    var attributeName: String {
        switch self {
            
        case .actorTerm:
            return "actorTerm"
        case .languageTerm:
            return "languageTerm"
        case .allArtistTerm:
            return "allArtistTerm"
        case .tvEpisodeTerm:
            return "tvEpisodeTerm"
        case .shortFilmTerm:
            return "shortFilmTerm"
        case .directorTerm:
            return "directorTerm"
        case .releaseYearTerm:
            return "releaseYearTerm"
        case .titleTerm:
            return "titleTerm"
        case .featureFilmTerm:
            return "featureFilmTerm"
        case .ratingIndex:
            return "ratingIndex"
        case .keywordsTerm:
            return "keywordsTerm"
        case .descriptionTerm:
            return "descriptionTerm"
        case .authorTerm:
            return "authorTerm"
        case .genreIndex:
            return "genreIndex"
        case .mixTerm:
            return "mixTerm"
        case .allTrackTerm:
            return "allTrackTerm"
        case .artistTerm:
            return "artistTerm"
        case .composerTerm:
            return "composerTerm"
        case .tvSeasonTerm:
            return "tvSeasonTerm"
        case .producerTerm:
            return "producerTerm"
        case .ratingTerm:
            return "ratingTerm"
        case .songTerm:
            return "songTerm"
        case .movieArtistTerm:
            return "movieArtistTerm"
        case .showTerm:
            return "showTerm"
        case .movieTerm:
            return "movieTerm"
        case .albumTerm:
            return "albumTerm"
        }
    }
}
