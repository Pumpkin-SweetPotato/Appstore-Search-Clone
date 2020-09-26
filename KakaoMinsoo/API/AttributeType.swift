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

enum MovieAttirubte: String, AttributeType {
    case actorTerm, genreIndex, artistTerm, shortFilmTerm, producerTerm, ratingTerm, directorTerm, releaseYearTerm, featureFilmTerm, movieArtistTerm, movieTerm, ratingIndex, descriptionTerm
    
    var attributeName: String {
        rawValue
    }
}

enum PodcaseAttriute: String, AttributeType {
    case titleTerm, languageTerm, authorTerm, genreIndex, artistTerm, ratingIndex, keywordsTerm, descriptionTerm
    
    var attributeName: String {
       rawValue
    }
}

enum MusicAttribute: String, AttributeType {
    
    case mixTerm, genreIndex, artistTerm, composerTerm, albumTerm, ratingIndex, songTerm
    
    var attributeName: String {
       rawValue
    }
}

enum MusicVideo: String, AttributeType {
    
    case genreIndex, artistTerm, albumTerm, ratingIndex, songTerm
    
    var attributeName: String {
       rawValue
    }
}

enum AudioBookAttribute: String, AttributeType {
    
    case titleTerm, authorTerm, genreIndex, ratingIndex
    
    var attributeName: String {
        rawValue
    }
}

enum ShortFile: String, AttributeType {
    
    case genreIndex, artistTerm, shortFilmTerm, ratingIndex, descriptionTerm
    
    var attributeName: String {
        rawValue
    }
}

enum SoftwareAttribute: String, AttributeType {

    case softwareDeveloper
    
    var attributeName: String {
        rawValue
    }
}

enum TvShowAttribute: String, AttributeType {
    
    case genreIndex, tvEpisodeTerm, showTerm, tvSeasonTerm, ratingIndex, descriptionTerm
    
    var attributeName: String {
        rawValue
    }
}

enum AllAttribute: String, AttributeType {
    case actorTerm, languageTerm, allArtistTerm, tvEpisodeTerm, shortFilmTerm, directorTerm, releaseYearTerm, titleTerm, featureFilmTerm, ratingIndex, keywordsTerm, descriptionTerm, authorTerm, genreIndex, mixTerm, allTrackTerm, artistTerm, composerTerm, tvSeasonTerm, producerTerm, ratingTerm, songTerm, movieArtistTerm, showTerm, movieTerm, albumTerm
    
    var attributeName: String {
        rawValue
    }
}
