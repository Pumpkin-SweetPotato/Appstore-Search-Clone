//
//  SearchResult.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/16.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation

struct SearchReponse: Codable {
    let resultCount: Int
    let results: [SearchResults]
}

// MARK: - Result
struct SearchResults: Codable {
    let advisories, appletvScreenshotUrls: [String]
    let artistID: Int
    let artistName: String
    let artistViewURL: String
    let artworkUrl100, artworkUrl512, artworkUrl60: String
    let averageUserRating: Float
    let averageUserRatingForCurrentVersion: Float
    let bundleID: String
    let contentAdvisoryRating: String
    let currency: String
    let currentVersionReleaseDate: String
    let resultDescription: String
    let features: [String]
    let fileSizeBytes: String
    let formattedPrice: String
    let genreIDS: [String]
    let genres: [String]
    let ipadScreenshotUrls: [String]
    let isGameCenterEnabled, isVppDeviceBasedLicensingEnabled: Bool
    let kind: String
    let languageCodesISO2A: [String]
    let minimumOSVersion: String
    let price, primaryGenreID: Int
    let primaryGenreName: String
    let releaseDate: Date?
    let releaseNotes: String?
    let screenshotUrls: [String]
    let sellerName: String
    let sellerURL: String?
    let supportedDevices: [String]
    let trackCensoredName, trackContentRating: String
    let trackID: Int
    let trackName: String
    let trackViewURL: String
    let userRatingCount, userRatingCountForCurrentVersion: Int
    let version, wrapperType: String

    enum CodingKeys: String, CodingKey {
        case advisories, appletvScreenshotUrls
        case artistID = "artistId"
        case artistName
        case artistViewURL = "artistViewUrl"
        case artworkUrl100, artworkUrl512, artworkUrl60, averageUserRating, averageUserRatingForCurrentVersion
        case bundleID = "bundleId"
        case contentAdvisoryRating, currency, currentVersionReleaseDate
        case resultDescription = "description"
        case features, fileSizeBytes, formattedPrice
        case genreIDS = "genreIds"
        case genres, ipadScreenshotUrls, isGameCenterEnabled, isVppDeviceBasedLicensingEnabled, kind, languageCodesISO2A
        case minimumOSVersion = "minimumOsVersion"
        case price
        case primaryGenreID = "primaryGenreId"
        case primaryGenreName, releaseDate, releaseNotes, screenshotUrls, sellerName
        case sellerURL = "sellerUrl"
        case supportedDevices, trackCensoredName, trackContentRating
        case trackID = "trackId"
        case trackName
        case trackViewURL = "trackViewUrl"
        case userRatingCount, userRatingCountForCurrentVersion, version, wrapperType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.advisories = try container.decode([String].self, forKey: .advisories)
        self.appletvScreenshotUrls = try container.decode([String].self, forKey: .appletvScreenshotUrls)
        self.artistID = try container.decode(Int.self, forKey: .artistID)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.artistViewURL = try container.decode(String.self, forKey: .artistViewURL)
        self.artworkUrl100 = try container.decode(String.self, forKey: .artworkUrl100)
        self.artworkUrl512 = try container.decode(String.self, forKey: .artworkUrl512)
        self.artworkUrl60 = try container.decode(String.self, forKey: .artworkUrl60)
        self.averageUserRating = try container.decode(Float.self, forKey: .averageUserRating)
        self.averageUserRatingForCurrentVersion = try container.decode(Float.self, forKey: .averageUserRatingForCurrentVersion)
        self.bundleID = try container.decode(String.self, forKey: .bundleID)
        self.contentAdvisoryRating = try container.decode(String.self, forKey: .contentAdvisoryRating)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.currentVersionReleaseDate = try container.decode(String.self, forKey: .currentVersionReleaseDate)
        self.resultDescription = try container.decode(String.self, forKey: .resultDescription)
        self.features = try container.decode([String].self, forKey: .features)
        self.fileSizeBytes = try container.decode(String.self, forKey: .fileSizeBytes)
        self.formattedPrice = try container.decode(String.self, forKey: .formattedPrice)
        self.genreIDS = try container.decode([String].self, forKey: .genreIDS)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.ipadScreenshotUrls = try container.decode([String].self, forKey: .ipadScreenshotUrls)
        self.isGameCenterEnabled = try container.decode(Bool.self, forKey: .isGameCenterEnabled)
        self.isVppDeviceBasedLicensingEnabled = try container.decode(Bool.self, forKey: .isVppDeviceBasedLicensingEnabled)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.languageCodesISO2A = try container.decode([String].self, forKey: .languageCodesISO2A)
        self.minimumOSVersion = try container.decode(String.self, forKey: .minimumOSVersion)
        self.price = try container.decode(Int.self, forKey: .price)
        self.primaryGenreID = try container.decode(Int.self, forKey: .primaryGenreID)
        self.primaryGenreName = try container.decode(String.self, forKey: .primaryGenreName)
        
        let releaseDateString = try container.decode(String.self, forKey: .releaseDate)
        self.releaseDate = DateConverter.convertDate(releaseDateString)
        
        self.releaseNotes = try container.decodeIfPresent(String.self, forKey: .releaseNotes)
        self.screenshotUrls = try container.decode([String].self, forKey: .screenshotUrls)
        self.sellerName = try container.decode(String.self, forKey: .sellerName)
        self.sellerURL = try container.decodeIfPresent(String.self, forKey: .sellerURL)
        self.supportedDevices = try container.decode([String].self, forKey: .supportedDevices)
        self.trackCensoredName = try container.decode(String.self, forKey: .trackCensoredName)
        self.trackContentRating = try container.decode(String.self, forKey: .trackContentRating)
        self.trackID = try container.decode(Int.self, forKey: .trackID)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.trackViewURL = try container.decode(String.self, forKey: .trackViewURL)
        self.userRatingCount = try container.decode(Int.self, forKey: .userRatingCount)
        self.userRatingCountForCurrentVersion = try container.decode(Int.self, forKey: .userRatingCountForCurrentVersion)
        self.version = try container.decode(String.self, forKey: .version)
        self.wrapperType = try container.decode(String.self, forKey: .wrapperType)
    }
    
    
}

class DateConverter {
    static func convertDate(_ dateString: String) -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-ssTHH:mm:ssZ"
        
        return dateFormatter.date(from: dateString)
    }
}
